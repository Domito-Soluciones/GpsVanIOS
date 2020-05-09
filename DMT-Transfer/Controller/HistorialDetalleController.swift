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

    
    var cantidadPasajeros:Int = 0
    let tableView = UITableView()
    var pasajeros:[Pasajero] = []
    var estado:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        let id = HistorialController.servicioId
        var servicio:[Servicio] = []
        for aux in Constantes.servicios {
            if(aux.id == id){
                servicio.append(aux)
            }
        }
        var i = 0
        if(servicio.count > 0){
            for aux in servicio {
                if(i == 0){
                    /*
                     self.idLabel.text = aux.id
                    self.clienteLabel.text = aux.empresa
                    self.fechaLabel.text = aux.fecha
                    self.horaLabel.text = aux.hora
                    self.rutaLabel.text = aux.ruta
                    self.tipoRutaLabel.text = aux.truta
                    self.tarifaLabel.text = aux.tarifa
                    self.observacionLabel.text = aux.observacion == "" ? "Sin observaciones" : aux.observacion
                    self.estado = aux.estado!*/
                }
                let idPasajero = aux.idPasajero
                let nombre = aux.nombrePasajero
                let destino = aux.destinoPasajero
                let telefono = aux.telefonoPasajero
                //let pasajero = Pasajero(id: idPasajero,nombre: nombre,destino: destino,telefono: telefono, estado: "0")
                //pasajeros.append(pasajero)
                i += 1
            }
            //self.pasajeroLabel.text = "\(i)"
            self.cantidadPasajeros = i
            configureTableView()
        }
        
    }
        
    func configureNavigationBar() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = .blue
        let navItem = UINavigationItem()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navItem.title = "Detalle Servicio"
        let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
        imagen.width = 50
        navItem.leftBarButtonItem = imagen
        navbar.items = [navItem]
        view.addSubview(navbar)
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        //tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //tableView.topAnchor.constraint(equalTo:self.observacionLabel.bottomAnchor).isActive = true
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



