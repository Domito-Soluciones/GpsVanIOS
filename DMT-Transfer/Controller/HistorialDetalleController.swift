//
//  HistorialDetalleController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HistorialDetalleController: UIViewController, UITableViewDelegate,  UITableViewDataSource{

    
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblRuta: UILabel!
    @IBOutlet weak var lblTipoRuta: UILabel!
    @IBOutlet weak var lblTarifa: UILabel!
    @IBOutlet weak var lblPasajeros: UILabel!
    @IBOutlet weak var lblObservacion: UILabel!
    
    var cantidadPasajeros:Int = 0
    let tableView = UITableView()
    var pasajeros:[Pasajero] = []
    var estado:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        let id = HistorialController.servicioId
        var servicio:[Servicio] = []
        let parameters: [String: AnyObject] = ["id": id as AnyObject];
        Alamofire.request(Constantes.URL_BASE_SERVICIO + "GetServicioHistorico.php", method: .post,parameters: parameters)
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
                                    if(i == 0){
                                        self.lblId.text = json[i]["servicio_id"].string!
                                        self.lblCliente.text = json[i]["servicio_cliente"].string!
                                        self.lblFecha.text = json[i]["servicio_fecha"].string!
                                        self.lblHora.text = json[i]["servicio_hora"].string!
                                        self.lblRuta.text = json[i]["servicio_ruta"].string!
                                        self.lblTipoRuta.text = json[i]["servicio_truta"].string!
                                        self.lblTarifa.text = json[i]["servicio_tarifa"].string!
                                        self.lblObservacion.text = json[i]["servicio_observacion"].string! == "" ? "Sin observaciones" : json[i]["servicio_observacion"].string!
                                        self.estado = json[i]["servicio_estado"].string!
                                        
                                    }
                                    let idPasajero = json[i]["servicio_pasajero_id_pasajero"].string!
                                    let nombre = json[i]["servicio_pasajero_nombre"].string!
                                    let destino = json[i]["servicio_destino"].string!
                                    let telefono = json[i]["servicio_pasajero_celular"].string!
                                    let pasajero = Pasajero(id: idPasajero,nombre: nombre,destino: destino,telefono: telefono, estado: "0",index:0)
                                    self.pasajeros.append(pasajero)
                                    i += 1
                                }
                                self.lblPasajeros.text = "\(i)"
                                self.cantidadPasajeros = i
                            }
                            self.view.backgroundColor = .white
                            self.configureTableView()
                        }
                         self.configureNavigationBar()
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
        
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Detalle Servicio"
        let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
        navigationItem.leftBarButtonItem = imagen
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        //tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo:self.lblObservacion.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant:250).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCellDetalle.self, forCellReuseIdentifier: "servicioDetalleCell")
    }
    
    @objc func volver(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cantidadPasajeros
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicioDetalleCell", for: indexPath) as! TableViewCellDetalle
        cell.pasajero = pasajeros[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



