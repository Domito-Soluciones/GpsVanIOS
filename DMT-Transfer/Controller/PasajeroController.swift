//
//  PasajeroController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PasajeroController: UIViewController, UITableViewDelegate,  UITableViewDataSource{

    let tableView = UITableView()
    var pasajeros:[Pasajero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func volver(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func configureTableView(){
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCellPasajero.self, forCellReuseIdentifier: "servicioCellPasajero")
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        //self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Servicio Iniciado"
        let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
        navigationItem.leftBarButtonItem = imagen
    }

     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pasajeros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicioCellPasajero", for: indexPath) as! TableViewCellPasajero
        cell.pasajero = pasajeros[indexPath.row]
        cell.viewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //recargar pasajeros
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       viewLoadSetup()
    }
    
    
    func viewLoadSetup(){
          pasajeros.removeAll()
          let conductor = Constantes.conductor.id
          let id = Constantes.conductor.servicioActual
          let parameters: [String: AnyObject] = ["conductor": conductor as AnyObject,"id": id as AnyObject];
          Alamofire.request(Constantes.URL_BASE_SERVICIO + "GetServicioProgramado.php", method: .post,parameters: parameters)
                  .validate(statusCode: 200..<300)
                  .responseJSON { response in
                      switch response.result {
                      case .success:
                          if response.result.value != nil{
                              let json = JSON(response.result.value)
                              var i = 0
                              var j = 0
                              if(json.count > 0){
                                  let tipo = json[0]["servicio_truta"].string!
                                  if(!Constantes.conductor.zarpeIniciado && tipo.contains("ZP")){
                                      let nombre = json[0]["servicio_cliente"].string!
                                      let telefono = ""
                                      let destino = json[0]["servicio_cliente_direccion"].string!
                                      let estado = ""
                                      let primero = Pasajero(
                                          id: "0",
                                          nombre: nombre,
                                          destino: destino,
                                          telefono: telefono,
                                          estado: estado,
                                          index: 0)
                                      //i = i + 1
                                      self.pasajeros.append(primero)
                                  }
                                  for _ in json {
                                      let idAux = json[i]["servicio_pasajero_id"].string!
                                      let nombre = json[i]["servicio_pasajero_nombre"].string!
                                      let telefono = json[i]["servicio_pasajero_celular"].string!
                                      let destino = json[i]["servicio_destino"].string!
                                      let estado = json[i]["servicio_pasajero_estado"].string!
                                      var index = j;
                                      if(!Constantes.conductor.zarpeIniciado && tipo.contains("ZP")){
                                          index = index+1
                                      }
                                      let aux = Pasajero(
                                          id: idAux,
                                          nombre: nombre,
                                          destino: destino,
                                          telefono: telefono,
                                          estado: estado,
                                          index: index)
                                    i = i + 1
                                     if(tipo.contains("ZP")){
                                          if (estado != "3" && estado != "2"){
                                              self.pasajeros.append(aux)
                                              j = j + 1
                                          }
                                      }
                                      else if(tipo.contains("RG")){
                                          if (estado != "3" && estado != "2" && estado != "1"){
                                              self.pasajeros.append(aux)
                                              j = j + 1
                                        }
                                      }
                                      else if(tipo.contains("XX")){
                                          if (estado != "3" && estado != "2" && estado != "1"){
                                              if(destino != ""){
                                                  self.pasajeros.append(aux)
                                                  j = j + 1
                                            }
                                          }
                                      }
                                      //i += 1
                                  }
                                  if(tipo.contains("RG")){
                                      let nombre = json[0]["servicio_cliente"].string!
                                      let telefono = ""
                                      let destino = json[0]["servicio_cliente_direccion"].string!
                                      let estado = ""
                                      let ultimo = Pasajero(
                                          id: "0",
                                          nombre: nombre,
                                          destino: destino,
                                          telefono: telefono,
                                          estado: estado,
                                          index: i)
                                      //i = i + 1
                                      self.pasajeros.append(ultimo)
                                  }
                                  self.view.backgroundColor = .white
                                  self.configureTableView()
                              }
                              if(self.pasajeros.count == 0){
                                //self.dismiss(animated: true, completion: nil)
                                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                let viewCtrl = storyboard.instantiateViewController(withIdentifier: "finServicioController")
                                viewCtrl.modalPresentationStyle = .fullScreen
                                viewCtrl.modalTransitionStyle = .crossDissolve
                                self.present(UINavigationController(rootViewController: viewCtrl), animated: true, completion: nil)
                                FinServicioController.idServicio = json[0]["servicio_id"].stringValue
                                FinServicioController.cliente = json[0]["servicio_cliente"].stringValue
                                FinServicioController.fecha = json[0]["servicio_fecha"].stringValue
                                FinServicioController.tarifa = json[0]["servicio_tarifa"].stringValue
                              }
                              else{
                                self.configureNavigationBar()
                                self.configureTableView()
                            }
                        
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

}

