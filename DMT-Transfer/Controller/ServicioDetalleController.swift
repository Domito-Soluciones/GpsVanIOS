//
//  ServicioDetalleController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServicioDetalleController: UIViewController, UITableViewDelegate,  UITableViewDataSource{

    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var clienteLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var horaLabel: UILabel!
    @IBOutlet weak var rutaLabel: UILabel!
    @IBOutlet weak var tipoRutaLabel: UILabel!
    @IBOutlet weak var tarifaLabel: UILabel!
    @IBOutlet weak var pasajeroLabel: UILabel!
    @IBOutlet weak var observacionLabel: UILabel!
    @IBOutlet weak var imageViewAceptar: UIImageView!
    @IBOutlet weak var imageViewCancelar: UIImageView!
    
    
    
    var cantidadPasajeros:Int = 0
    let tableView = UITableView()
    var pasajeros:[Pasajero] = []
    var estado:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        let id = Constantes.conductor.servicioActual
        let tapGestureRecognizerAceptar = UITapGestureRecognizer(target: self, action: #selector(aceptarServicio(tapGestureRecognizer:)))
        let tapGestureRecognizerCancelar = UITapGestureRecognizer(target: self, action: #selector(cancelarServicio(tapGestureRecognizer:)))
        imageViewAceptar.isUserInteractionEnabled = true
        imageViewCancelar.isUserInteractionEnabled = true
        imageViewAceptar.addGestureRecognizer(tapGestureRecognizerAceptar)
        imageViewCancelar.addGestureRecognizer(tapGestureRecognizerCancelar)
        
        var servicio:[Servicio] = []
        for aux in Constantes.servicios {
            if(aux.id == id){
                servicio.append(aux)
            }
        }
        var i = 0
        var servicioAnterior = ""
        if(servicio.count > 0){
            for aux in servicio {
                if(i == 0){
                    self.idLabel.text = aux.id
                    self.clienteLabel.text = aux.empresa
                    self.fechaLabel.text = aux.fecha
                    self.horaLabel.text = aux.hora
                    self.rutaLabel.text = aux.ruta
                    self.tipoRutaLabel.text = aux.truta
                    self.tarifaLabel.text = aux.tarifa
                    self.observacionLabel.text = aux.observacion == "" ? "Sin observaciones" : aux.observacion
                    self.estado = aux.estado!
                    Constantes.conductor.servicioActualRuta = self.tipoRutaLabel.text!
                }
                let idPasajero = aux.idPasajero
                let nombre = aux.nombrePasajero
                let destino = aux.destinoPasajero
                let telefono = aux.telefonoPasajero
                let pasajero = Pasajero(id: idPasajero,nombre: nombre,destino: destino,telefono: telefono, estado: "0", index: i)
                if(servicioAnterior != idPasajero){
                    pasajeros.append(pasajero)
                    i += 1
                }
                servicioAnterior = idPasajero!
                
            }
            self.pasajeroLabel.text = "\(i)"
            self.cantidadPasajeros = i
            configureTableView()
            print(self.estado)
            if(self.estado == "4"){
                imageViewAceptar.translatesAutoresizingMaskIntoConstraints = false
                self.imageViewAceptar.image = UIImage(named: "okazul")
                imageViewAceptar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                imageViewAceptar.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor, constant:-20).isActive = true
                imageViewAceptar.widthAnchor.constraint(equalToConstant:100).isActive = true
                imageViewAceptar.heightAnchor.constraint(equalToConstant:100).isActive = true
                self.imageViewCancelar.isHidden = true
            }
            else{
                imageViewAceptar.translatesAutoresizingMaskIntoConstraints = false
                
                imageViewAceptar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50).isActive = true
                imageViewAceptar.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant:-20).isActive = true
                imageViewAceptar.widthAnchor.constraint(equalToConstant:100).isActive = true
                imageViewAceptar.heightAnchor.constraint(equalToConstant:100).isActive = true
                
                imageViewCancelar.translatesAutoresizingMaskIntoConstraints = false
                imageViewCancelar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50).isActive = true
                imageViewCancelar.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant:-20).isActive = true
                imageViewCancelar.widthAnchor.constraint(equalToConstant:90).isActive = true
                imageViewCancelar.heightAnchor.constraint(equalToConstant:90).isActive = true
                
            }
        }
        
    }
        
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Detalle Servicios"
        let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
        navigationItem.leftBarButtonItem = imagen
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:self.imageViewAceptar.bottomAnchor,constant: -100).isActive = true
        tableView.topAnchor.constraint(equalTo:self.observacionLabel.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCellDetalle.self, forCellReuseIdentifier: "servicioDetalleCell")
    }
    
    @objc func aceptarServicio(tapGestureRecognizer: UITapGestureRecognizer){
        if(self.estado == "1"){
            let parameters: [String: AnyObject] = ["id" : self.idLabel.text as AnyObject,"estado": "3" as AnyObject, "observacion": "" as AnyObject];
            Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicio.php", method: .post,parameters: parameters)
                    .validate(statusCode: 200..<300)
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            if response.result.value != nil {
                                Constantes.rootController!.obtenerServiciosProgramados()
                                self.cambiarEstadoNotificacion(id: self.idLabel.text!)
                            }
                            break
                        case .failure( _):
                            Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                            break
                        }
            }
        }
        else if(self.estado == "3"){
            self.cambiarEstadoNotificacion(id: self.idLabel.text!)
            let start = fechaLabel.text!+" "+horaLabel.text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "dd-MM-yyyy HH:mm:ss"
            let startDate = dateFormatter.date(from: start)
            let currentDate = Date()
            let fechaMil = (startDate!.timeIntervalSince1970 * 1000.0).rounded()
            let actMil = (currentDate.timeIntervalSince1970 * 1000.0).rounded()
            let data = abs(fechaMil - actMil);
            if (data <= 3.6e+6 || actMil >= fechaMil) {
                let parameters: [String: AnyObject] = ["id" : self.idLabel.text as AnyObject,"estado": "4" as AnyObject, "observacion": "" as AnyObject];
                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicio.php", method: .post,parameters: parameters)
                        .validate(statusCode: 200..<300)
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                if response.result.value != nil {
                                    Constantes.rootController!.obtenerServiciosProgramados()
                                    let controller = PasajeroController()
                                    controller.modalPresentationStyle = .fullScreen
                                    controller.modalTransitionStyle = .crossDissolve
                                    self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
                                }
                                break
                            case .failure( _):
                                Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                                break
                            }
                }
            } else {
                Util.showToast(view: Constantes.rootController!.view, message: "Falta mas de 1 hora para el inicio del servicio")
            }
        }
        if(self.estado == "4"){
            let controller = PasajeroController()
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    func cambiarEstadoNotificacion(id:String){
        let parameters: [String: AnyObject] = ["id" : id as AnyObject,"servicio": id as AnyObject];
        Alamofire.request(Constantes.URL_BASE_NOTIFICACION + "ModEstadoNotificacion.php", method: .post,parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if response.result.value != nil {
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            
                            Util.showToast(view: self.view, message: "Servicio aceptado")
                        }
                        break
                    case .failure( _):
                        Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                        break
                    }
        }    }
    
    @objc func cancelarServicio(tapGestureRecognizer: UITapGestureRecognizer){
        
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


