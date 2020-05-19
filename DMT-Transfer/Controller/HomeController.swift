//
//  HomeController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeController: UIViewController, UITableViewDelegate,  UITableViewDataSource, UNUserNotificationCenterDelegate{

    var servicios:[Servicio] = []
    let tableView = UITableView()
    var delegate: HomeControllerDelegate?
    var refreshControl = UIRefreshControl()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Constantes.rootController = self
        UNUserNotificationCenter.current().delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Cargando...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        NotificationCenter.default.addObserver(self, selector: #selector(onResume), name:
        UIApplication.willEnterForegroundNotification, object: nil)
    }
        
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.reloadData()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "servicioCell")
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationItem.title = "Proximos Servicios"
        let imagen = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleMenuToggle))
        navigationItem.leftBarButtonItem = imagen
    }

     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicioCell", for: indexPath) as! TableViewCell
        cell.servicio = servicios[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = servicios[indexPath.row].id
        if(id != ""){
            print("row: \(id!)")
            Constantes.conductor.servicioActual = id!
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let viewCtrl = storyboard.instantiateViewController(withIdentifier: "servicioDetalleController")
            self.present(UINavigationController(rootViewController: viewCtrl), animated: true, completion: nil)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
     
        completionHandler([.alert, .sound])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obtenerServiciosProgramados()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("problemas de memoria")
    }

    func obtenerServiciosProgramados(){
        servicios.removeAll()
        Constantes.servicios.removeAll()
        let conductor = Constantes.conductor.id
               let parameters: [String: AnyObject] = ["conductor": conductor as AnyObject];
               Alamofire.request(Constantes.URL_BASE_SERVICIO + "GetServiciosProgramados.php", method: .post,parameters: parameters)
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
                                           let cliente = json[i]["servicio_cliente"].string!
                                           let estado = json[i]["servicio_estado"].string!
                                           let ruta = json[i]["servicio_ruta"].string!
                                           let truta = json[i]["servicio_truta"].string!
                                           let tarifa = json[i]["servicio_tarifa"].string!
                                           let observacion = json[i]["servicio_observacion"].string!
                                           let pasajeroId = json[i]["servicio_pasajero_id"].string!
                                           let pasajeroNombre = json[i]["servicio_pasajero_nombre"].string!
                                           let pasajeroDestino = json[i]["servicio_destino"].string!
                                           let pasajeroTelefono = json[i]["servicio_pasajero_celular"].string!
                                           let aux = Servicio(
                                               id: id,
                                               fecha: fecha,
                                               hora: hora,
                                               empresa: cliente,
                                               estado: estado,
                                               ruta: ruta,
                                               truta: truta,
                                               tarifa: tarifa,
                                               observacion: observacion,
                                               idPasajero: pasajeroId,
                                               nombrePasajero: pasajeroNombre,
                                               destinoPasajero: pasajeroDestino,
                                               telefonoPasajero: pasajeroTelefono)
                                           if(servicioAnterior != id){
                                              self.servicios.append(aux)
                                           }
                                           Constantes.servicios.append(aux)
                                           Util.enviarNotificacion(id: id,titulo: "",subtitulo: "",cuerpo: "")
                                           servicioAnterior = id
                                           i += 1
                                       }
                                       self.view.backgroundColor = .white
                                       self.configureTableView()
                                   }
                                   else{
                                       Util.showToast(view: self.view,message: "No hay servicios programados")
                                   }
                                if(self.servicios.count == 0){
                                let aux = Servicio(
                                    id: "",
                                    fecha: "",
                                    hora: "",
                                    empresa: "",
                                    estado: "",
                                    ruta: "",
                                    truta: "",
                                    tarifa: "",
                                    observacion: "",
                                    idPasajero: "",
                                    nombrePasajero: "",
                                    destinoPasajero: "",
                                    telefonoPasajero: "")
                                    self.servicios.append(aux)
                                    self.configureTableView()
                                }
                                   self.configureNavigationBar()
                               }
                               break
                           case .failure( _):
                               Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                               break
                           }
               }
            }
    
    @objc func refresh(){
        obtenerServiciosProgramados()
        refreshControl.endRefreshing()
    }
       
    @objc func onResume() {
        print("")
    }
    
}

