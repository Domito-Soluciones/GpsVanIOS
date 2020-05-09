//
//  ProduccionController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProduccionController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    var servicios:[Servicio] = []
    let tableView = UITableView()
    
    public static var servicioId:String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let conductor = Constantes.conductor.id
        let fecha = Date()
        let fechaDesde = Calendar.current.date(byAdding: .month, value: -2, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let hasta = formatter.string(from: fecha)
        let desde = formatter.string(from: fechaDesde!)
        let parameters: [String: AnyObject] = ["conductor": conductor as AnyObject,"hasta": hasta as AnyObject, "desde": desde as AnyObject,
            "hhasta": "00:00:00" as AnyObject, "hdesde": "00:00:00" as AnyObject , "estado": "5" as AnyObject];
        Alamofire.request(Constantes.URL_BASE_LIQUIDACION + "GetProduccion.php", method: .post,parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if response.result.value != nil{
                            var servicioAnterior = ""
                            let json = JSON(response.result.value)
                            var i = 0
                            if(json.count > 0){
                                for _ in json {
                                    let id = json[i]["servicio_id"].string!
                                    let fecha = json[i]["servicio_fecha"].string!
                                    let hora = json[i]["servicio_hora"].string!
                                    let tarifa = json[i]["servicio_tarifa1"].string!
                                    let aux = Servicio(
                                        id: id,
                                        fecha: fecha,
                                        hora: hora,
                                        empresa: nil,
                                        estado: nil,
                                        ruta: nil,
                                        truta: nil,
                                        tarifa: tarifa,
                                        observacion: nil,
                                        idPasajero: nil,
                                        nombrePasajero: nil,
                                        destinoPasajero: nil,
                                        telefonoPasajero: nil)
                                    if(servicioAnterior != id){
                                       self.servicios.append(aux)
                                    }
                                    servicioAnterior = id
                                    i += 1
                                }
                                self.view.backgroundColor = .white
                                self.configureTableView()
                            }
                            else{
                                Util.showToast(view: self.view,message: "No hay producción registrada")
                            }
                            self.configureNavigationBar()
                        }
                        break
                    case .failure(let error):
                        print(error)
                        let code = response.response!.statusCode
                        print(code)
                        Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                        break
                    }
        }
    }
        
    @objc func volver(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCellProduccion.self, forCellReuseIdentifier: "servicioCellProduccion")
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Producción"
        let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
        navigationItem.leftBarButtonItem = imagen
    }

     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicioCellProduccion", for: indexPath) as! TableViewCellProduccion
        cell.servicio = servicios[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("")
    }
    
}

