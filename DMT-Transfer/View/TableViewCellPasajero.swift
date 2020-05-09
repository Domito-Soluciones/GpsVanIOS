//
//  TableViewCellPasajero.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-04-20.
//  Copyright © 2020 Domito. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class TableViewCellPasajero: UITableViewCell {
    
    var viewController:UIViewController? = nil
    
    var pasajero:Pasajero? {
         didSet {
             guard let aux = pasajero else {return}
             let id = aux.id
             let nombre =  aux.nombre
             let destino = aux.destino
             let telefono = aux.telefono
             let index = aux.index
             nombreLabel.text  = "Nombre: "+nombre!
             destinoLabel.text = "Direccion: "+destino!
             idLabel.text = id
             if(telefono != ""){
                telefonoLabel.text = telefono
                telefonoImageView.image = UIImage(named: "telefono")
                let tapGestureRecognizerAceptar = UITapGestureRecognizer(target: self, action: #selector(llamar))
                telefonoImageView.isUserInteractionEnabled = true
                telefonoImageView.addGestureRecognizer(tapGestureRecognizerAceptar)
             }
             else{
                telefonoLabel.isHidden = true
            }
            
             navegarImageView.image = UIImage(named: "navegar")
             aceptarImageView.image = UIImage(named: "confirmar")
             cancelarImageView.image = UIImage(named: "cerrar")
             if(index! > 0){
                navegarImageView.isHidden = true
                aceptarImageView.isHidden = true
             }
             let tipo = Constantes.conductor.servicioActualRuta
             if(tipo.contains("RG")){
                 if(index == 0){
                     let tapGestureRecognizerNavegar = UITapGestureRecognizer(target: self, action: #selector(navegar))
                     navegarImageView.isUserInteractionEnabled = true
                     navegarImageView.addGestureRecognizer(tapGestureRecognizerNavegar)
                    
                     let tapGestureRecognizerIniciar = UITapGestureRecognizer(target: self, action: #selector(iniciarRG))
                     aceptarImageView.isUserInteractionEnabled = true
                     aceptarImageView.addGestureRecognizer(tapGestureRecognizerIniciar)
                 }
                 else{
                     aceptarImageView.isHidden = true
                 }
                 let tapGestureRecognizerCancelar = UITapGestureRecognizer(target: self, action: #selector(cancelarRG))
                 cancelarImageView.isUserInteractionEnabled = true
                 cancelarImageView.addGestureRecognizer(tapGestureRecognizerCancelar)
             }
             else if(tipo.contains("ZP")){
                if(index == 0){
                    let tapGestureRecognizerNavegar = UITapGestureRecognizer(target: self, action: #selector(navegar))
                    navegarImageView.isUserInteractionEnabled = true
                    navegarImageView.addGestureRecognizer(tapGestureRecognizerNavegar)
                }
                else{
                    aceptarImageView.isHidden = true
                }
                let tapGestureRecognizerIniciar = UITapGestureRecognizer(target: self, action: #selector(iniciarZP))
                aceptarImageView.isUserInteractionEnabled = true
                aceptarImageView.addGestureRecognizer(tapGestureRecognizerIniciar)
                
                let tapGestureRecognizerCancelar = UITapGestureRecognizer(target: self, action: #selector(cancelarZP))
                cancelarImageView.isUserInteractionEnabled = true
                cancelarImageView.addGestureRecognizer(tapGestureRecognizerCancelar)
             }
             else if(tipo.contains("ESP")){
                 if(index == 0){
                     let tapGestureRecognizerNavegar = UITapGestureRecognizer(target: self, action: #selector(navegar))
                     navegarImageView.isUserInteractionEnabled = true
                     navegarImageView.addGestureRecognizer(tapGestureRecognizerNavegar)
                    
                     let tapGestureRecognizerIniciar = UITapGestureRecognizer(target: self, action: #selector(iniciarESP))
                     aceptarImageView.isUserInteractionEnabled = true
                     aceptarImageView.addGestureRecognizer(tapGestureRecognizerIniciar)
                 }
                 else{
                     aceptarImageView.isHidden = true
                 }
                 let tapGestureRecognizerCancelar = UITapGestureRecognizer(target: self, action: #selector(cancelarRG))
                 cancelarImageView.isUserInteractionEnabled = true
                 cancelarImageView.addGestureRecognizer(tapGestureRecognizerCancelar)
            }
        }
     }
    
     let destinoLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 12)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.clipsToBounds = true
         return label
     }()
     
     let nombreLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.clipsToBounds = true
         return label
     }()
    let idLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    let telefonoLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.clipsToBounds = true
        label.isHidden = true
         return label
     }()
    let telefonoImageView:UIImageView = {
         let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.translatesAutoresizingMaskIntoConstraints = false
         img.clipsToBounds = true
         return img
     }()
    
    let navegarImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    let aceptarImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    let cancelarImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    @objc func llamar(){
        Util.llamar(numero: telefonoLabel.text!)
    }
    
    @objc func navegar(){
        Util.navegar()
    }
    
    @objc func iniciarRG(){
        let idPasajero = idLabel.text
        Constantes.conductor.pasajeroActual = idPasajero!
        if(idPasajero != "0"){
            let mensaje = "¿ Esta seguro que desea dejar al pasajero aquí ?"
            let alert = UIAlertController(title: "Dejar pasajero", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                Constantes.conductor.pasajeroRecogido = false;
                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "" as AnyObject, "estado": "1" as AnyObject];
                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                            .validate(statusCode: 200..<300)
                            .responseJSON { response in
                                switch response.result {
                                case .success:
                                    if response.result.value != nil {
                                        //agregar geocoder
                                        self.recargarPasajeros()
                                        Util.showToast(view: self.viewController!.view,message: "Pasajero Recogido")
                                    }
                                    break
                                case .failure( _):
                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                    break
                                }
                    }
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
        else{
            finalizar()
        }
    }
    
    @objc func iniciarZP(){
        let idPasajero = idLabel.text
        Constantes.conductor.pasajeroActual = idPasajero!
        if(Constantes.conductor.zarpeIniciado){
            Constantes.conductor.pasajeroActual = idPasajero!
            let mensaje = "¿ Esta seguro que desea dejar al pasajero aquí ?"
            let alert = UIAlertController(title: "Dejar pasajero", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                Constantes.conductor.pasajeroRecogido = false;
                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": idPasajero as AnyObject, "observacion": "" as AnyObject, "estado": "3" as AnyObject];
                print(parameters)
                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                            .validate(statusCode: 200..<300)
                            .responseJSON { response in
                                switch response.result {
                                case .success:
                                    if response.result.value != nil {
                                        self.recargarPasajeros()
                                    }
                                    break
                                case .failure( _):
                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                    break
                                }
                    }
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
        else{
            Constantes.conductor.pasajeroActual = idPasajero!
            let mensaje = "¿ Esta seguro que llegaste al punto de origen ?"
            let alert = UIAlertController(title: "Llegaste al punto de origen", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                Constantes.conductor.zarpeIniciado = true;
                self.recargarPasajeros()
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func cancelarRG(){
        let idPasajero = idLabel.text
        Constantes.conductor.pasajeroRecogido = false
        Constantes.conductor.pasajeroActual = idPasajero!
        if(idPasajero != "0"){
            let mensaje = "¿ Esta seguro que desea cancelar el servicio ?"
            let alert = UIAlertController(title: "Cancelar Servicio", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                let alert = UIAlertController(title: "Motivo Cancelación", message: "Ingrese motivo de cancelación", preferredStyle: .alert)
                    alert.addTextField { (textField) in
                    textField.text = ""
                }
                alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0]
                    if(textField!.text != ""){
                        let parameters: [String: AnyObject] = ["id" : Constantes.conductor.servicioActual as AnyObject,"estado": "6" as AnyObject, "observacion": textField?.text as AnyObject];
                        Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicio.php", method: .post,parameters: parameters)
                                .validate(statusCode: 200..<300)
                                .responseJSON { response in
                                    switch response.result {
                                    case .success:
                                        if response.result.value != nil {
                                            let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "" as AnyObject, "estado": "2" as AnyObject];
                                            Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                                        .validate(statusCode: 200..<300)
                                                        .responseJSON { response in
                                                            switch response.result {
                                                            case .success:
                                                                if response.result.value != nil {
                                                                    Util.showToast(view: self.viewController!.view,message: "Servicio Cancelado")
                                                                }
                                                                break
                                                            case .failure( _):
                                                                Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                                break
                                                            }
                                                }
                                        }
                                        break
                                    case .failure( _):
                                        Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                        break
                                    }
                        }
                    }
                    else{
                        Util.showToast(view: self.viewController!.view, message: "Debe ingresar un motivo de cancelación")
                    }
                }))
                self.viewController!.present(alert, animated: true, completion: nil)
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
        else{
            let mensaje = "¿ Esta seguro que este pasajero no abordara ?"
            let alert = UIAlertController(title: "Cancelar Usuario", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                let alert = UIAlertController(title: "Motivo Cancelación", message: "Ingrese motivo de cancelación", preferredStyle: .alert)
                    alert.addTextField { (textField) in
                    textField.text = ""
                }
                alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
                    let alert = UIAlertController(title: "Cancelar Usuario", message: "¿ Esta seguro que este pasajero no abordara ?", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "Pasajero no contactado", style: .default, handler: { (_) in
                                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "Pasajero no contactado" as AnyObject, "estado": "2" as AnyObject];
                                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                            .validate(statusCode: 200..<300)
                                            .responseJSON { response in
                                                switch response.result {
                                                case .success:
                                                    if response.result.value != nil {
                                                    Util.showToast(view: self.viewController!.view,message: "Pasajero Cancelado")
                                                    }
                                                    break
                                                case .failure( _):
                                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                    break
                                                }
                                    }
                            }))
                            alert.addAction(UIAlertAction(title: "Pasajero enfermo", style: .default, handler: { (_) in
                                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "Pasajero enfermo" as AnyObject, "estado": "2" as AnyObject];
                                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                            .validate(statusCode: 200..<300)
                                            .responseJSON { response in
                                                switch response.result {
                                                case .success:
                                                    if response.result.value != nil {
                                                    Util.showToast(view: self.viewController!.view,message: "Pasajero Cancelado")
                                                    }
                                                    break
                                                case .failure( _):
                                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                    break
                                                }
                                    }
                            }))
                            alert.addAction(UIAlertAction(title: "Otro motivo", style: .destructive, handler: { (_) in
                                    let alert = UIAlertController(title: "Motivo Cancelación", message: "Ingrese motivo de cancelación", preferredStyle: .alert)
                                        alert.addTextField { (textField) in
                                        textField.text = ""
                                    }
                                    alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
                                        let textField = alert?.textFields![0]
                                        let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": textField?.text as AnyObject, "estado": "2" as AnyObject];
                                        Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                                        .validate(statusCode: 200..<300)
                                                        .responseJSON { response in
                                                            switch response.result {
                                                            case .success:
                                                                if response.result.value != nil {
                                                                Util.showToast(view: self.viewController!.view,message: "Pasajero Cancelado")
                                                                }
                                                                break
                                                            case .failure( _):
                                                                Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                                break
                                                            }
                                                }
                                    }))
                                    self.viewController!.present(alert, animated: true, completion: nil)
                            }))
                    self.viewController!.present(alert, animated: true, completion: nil)
                }))
                self.viewController!.present(alert, animated: true, completion: nil)
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func cancelarZP(){
        let idPasajero = idLabel.text
        Constantes.conductor.pasajeroActual = idPasajero!
        if(idPasajero != "0"){
            let mensaje = "¿ Esta seguro que desea cancelar el servicio ?"
            let alert = UIAlertController(title: "Cancelar Servicio", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                let alert = UIAlertController(title: "Motivo Cancelación", message: "Ingrese motivo de cancelación", preferredStyle: .alert)
                    alert.addTextField { (textField) in
                    textField.text = ""
                }
                alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0]
                    if(textField!.text != ""){
                        let parameters: [String: AnyObject] = ["id" : Constantes.conductor.servicioActual as AnyObject,"estado": "6" as AnyObject, "observacion": textField?.text as AnyObject];
                        Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicio.php", method: .post,parameters: parameters)
                                .validate(statusCode: 200..<300)
                                .responseJSON { response in
                                    switch response.result {
                                    case .success:
                                        if response.result.value != nil {
                                            let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "" as AnyObject, "estado": "2" as AnyObject];
                                            Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                                        .validate(statusCode: 200..<300)
                                                        .responseJSON { response in
                                                            switch response.result {
                                                            case .success:
                                                                if response.result.value != nil {
                                                                    Util.showToast(view: self.viewController!.view,message: "Servicio Cancelado")
                                                                }
                                                                break
                                                            case .failure( _):
                                                                Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                                break
                                                            }
                                                }
                                        }
                                        break
                                    case .failure( _):
                                        Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                        break
                                    }
                        }
                    }
                    else{
                        Util.showToast(view: self.viewController!.view, message: "Debe ingresar un motivo de cancelación")
                    }
                }))
                self.viewController!.present(alert, animated: true, completion: nil)
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
        else{
            let mensaje = "¿ Esta seguro que este pasajero no abordara ?"
            let alert = UIAlertController(title: "Cancelar Usuario", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                let alert = UIAlertController(title: "Motivo Cancelación", message: "Ingrese motivo de cancelación", preferredStyle: .alert)
                    alert.addTextField { (textField) in
                    textField.text = ""
                }
                alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
                    let alert = UIAlertController(title: "Cancelar Usuario", message: "¿ Esta seguro que este pasajero no abordara ?", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "Pasajero no contactado", style: .default, handler: { (_) in
                                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "Pasajero no contactado" as AnyObject, "estado": "2" as AnyObject];
                                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                            .validate(statusCode: 200..<300)
                                            .responseJSON { response in
                                                switch response.result {
                                                case .success:
                                                    if response.result.value != nil {
                                                    Util.showToast(view: self.viewController!.view,message: "Pasajero Cancelado")
                                                    }
                                                    break
                                                case .failure( _):
                                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                    break
                                                }
                                    }
                            }))
                            alert.addAction(UIAlertAction(title: "Pasajero enfermo", style: .default, handler: { (_) in
                                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "Pasajero enfermo" as AnyObject, "estado": "2" as AnyObject];
                                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                            .validate(statusCode: 200..<300)
                                            .responseJSON { response in
                                                switch response.result {
                                                case .success:
                                                    if response.result.value != nil {
                                                    Util.showToast(view: self.viewController!.view,message: "Pasajero Cancelado")
                                                    }
                                                    break
                                                case .failure( _):
                                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                    break
                                                }
                                    }
                            }))
                            alert.addAction(UIAlertAction(title: "Otro motivo", style: .destructive, handler: { (_) in
                                    let alert = UIAlertController(title: "Motivo Cancelación", message: "Ingrese motivo de cancelación", preferredStyle: .alert)
                                        alert.addTextField { (textField) in
                                        textField.text = ""
                                    }
                                    alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
                                        let textField = alert?.textFields![0]
                                        let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": textField?.text as AnyObject, "estado": "2" as AnyObject];
                                        Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                                                        .validate(statusCode: 200..<300)
                                                        .responseJSON { response in
                                                            switch response.result {
                                                            case .success:
                                                                if response.result.value != nil {
                                                                Util.showToast(view: self.viewController!.view,message: "Pasajero Cancelado")
                                                                }
                                                                break
                                                            case .failure( _):
                                                                Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                                break
                                                            }
                                                }
                                    }))
                                    self.viewController!.present(alert, animated: true, completion: nil)
                            }))
                    self.viewController!.present(alert, animated: true, completion: nil)
                }))
                self.viewController!.present(alert, animated: true, completion: nil)
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func iniciarESP(){
        let idPasajero = idLabel.text
        Constantes.conductor.pasajeroActual = idPasajero!
        if(idPasajero != "0"){
            let mensaje = "¿ Esta seguro que desea dejar al pasajero aquí ?"
            let alert = UIAlertController(title: "Dejar pasajero", message: mensaje,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Si",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
                Constantes.conductor.pasajeroRecogido = false;
                let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "idPasajero": Constantes.conductor.pasajeroActual as AnyObject, "observacion": "" as AnyObject, "estado": "1" as AnyObject];
                Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajero.php", method: .post,parameters: parameters)
                            .validate(statusCode: 200..<300)
                            .responseJSON { response in
                                switch response.result {
                                case .success:
                                    if response.result.value != nil {
                                        //agregar geocoder
                                        self.recargarPasajeros()
                                        Util.showToast(view: self.viewController!.view,message: "Pasajero Recogido")
                                        //if (index == getItemCount() -1){
                                        //    finalizar()
                                        //}
                                    }
                                    break
                                case .failure( _):
                                    Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                    break
                                }
                    }
            }))
            self.viewController!.present(alert, animated: true, completion: nil)
        }
        else{
            finalizar()
        }
    }
    
    func finalizar(){
        let parameters: [String: AnyObject] = ["id" : Constantes.conductor.servicioActual as AnyObject,"estado": "5" as AnyObject, "observacion": "" as AnyObject];
        Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicio.php", method: .post,parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if response.result.value != nil {
                            let parameters: [String: AnyObject] = ["idServicio": Constantes.conductor.servicioActual as AnyObject, "estado": "3" as AnyObject];
                            Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicioPasajeros.php", method: .post,parameters: parameters)
                                        .validate(statusCode: 200..<300)
                                        .responseJSON { response in
                                            switch response.result {
                                            case .success:
                                                if response.result.value != nil {
                                                    if(Constantes.conductor.servicioActualRuta.contains("RG")){
                                                        Util.showToast(view: self.viewController!.view,message: "Servicio Terminado")
                                                        Constantes.conductor.servicioActual = ""
                                                        //let controller = FinServicioController()
                                                        //self.viewController?.present(UINavigationController, animated: true, completion: nil)
                                                    }
                                                }
                                                break
                                            case .failure( _):
                                                Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                                                break
                                            }
                                }
                        }
                        break
                    case .failure( _):
                        Util.showToast(view: self.viewController!.view,message: "Ocurrio un error en el servidor ")
                        break
                    }
        }    }
    
    func recargarPasajeros(){
        self.viewController!.viewWillAppear(true)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         self.contentView.addSubview(nombreLabel)
         self.contentView.addSubview(destinoLabel)
         self.contentView.addSubview(telefonoImageView)
         self.contentView.addSubview(navegarImageView)
         self.contentView.addSubview(aceptarImageView)
        self.contentView.addSubview(cancelarImageView)
         
         nombreLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
         nombreLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
         
         destinoLabel.widthAnchor.constraint(equalToConstant:300).isActive = true
         destinoLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
         destinoLabel.topAnchor.constraint(equalTo:self.nombreLabel.bottomAnchor).isActive = true
        
         telefonoImageView.topAnchor.constraint(equalTo:self.destinoLabel.bottomAnchor).isActive = true
         telefonoImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
         telefonoImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
         navegarImageView.topAnchor.constraint(equalTo:self.destinoLabel.bottomAnchor).isActive = true
         navegarImageView.leadingAnchor.constraint(equalTo:self.telefonoImageView.trailingAnchor, constant:20).isActive = true
         navegarImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
         navegarImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        aceptarImageView.topAnchor.constraint(equalTo:self.destinoLabel.bottomAnchor).isActive = true
        aceptarImageView.leadingAnchor.constraint(equalTo:self.navegarImageView.trailingAnchor, constant:20).isActive = true
        aceptarImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        aceptarImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        cancelarImageView.topAnchor.constraint(equalTo:self.destinoLabel.bottomAnchor).isActive = true
        cancelarImageView.leadingAnchor.constraint(equalTo:self.aceptarImageView.trailingAnchor, constant:20).isActive = true
        cancelarImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        cancelarImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
    }
     
     required init?(coder aDecoder: NSCoder) {
         
         super.init(coder: aDecoder)
     }
 }
