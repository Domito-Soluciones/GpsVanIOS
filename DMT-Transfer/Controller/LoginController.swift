//
//  LoginController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginController: UIViewController {
    
    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var chkREc: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nickUsuario = UserDefaults.standard.string(forKey: "nickUsuario")
        let claveUsuario = UserDefaults.standard.string(forKey: "claveUsuario")
        let recordar = UserDefaults.standard.string(forKey: "recordar")
        if(recordar == "1"){
            txtUsuario.text = nickUsuario
            txtPassword.text = claveUsuario
            Constantes.conductor.recordarSesion = true
            chkREc.isOn = true
        }
        if(Constantes.conductor.activo){
            let idUsuario = UserDefaults.standard.string(forKey: "idUsuario")
            let claveUsuario = UserDefaults.standard.string(forKey: "claveUsuario")
            if(idUsuario != ""){
                let aux = Int(idUsuario!) ?? 0
                Constantes.conductor.id = aux
            }
            
            if(idUsuario != "" && claveUsuario != ""){
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewCtrl = storyboard.instantiateViewController(withIdentifier: "containerController")
                viewCtrl.modalPresentationStyle = .fullScreen
                viewCtrl.modalTransitionStyle = .crossDissolve
                self.present(viewCtrl, animated: true, completion: nil)
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        view.addGestureRecognizer(tap)
        
    }
   
    
     @objc func taped(){
    
        self.view.endEditing(true)
    
    }

    @IBAction func valueChanged(_ sender: Any) {
        print(chkREc.isOn)
        if(chkREc.isOn){
            Constantes.conductor.recordarSesion = true;
        }
        else{
            Constantes.conductor.recordarSesion = false;
        }
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        let user = txtUsuario.text
        let password = txtPassword.text
        if(user != "" && password != ""){
            self.login()
        }
        else{
            Util.showToast(view: self.view,message: "Ingrese tanto usuario como password")
        }    }
    
    func login(){
        view.endEditing(true)
        let usuario = txtUsuario.text
                let password = txtPassword.text?.base64Encoded()
                let parameters: [String: AnyObject] = ["usuario": usuario as AnyObject, "password": password as AnyObject];        Alamofire.request(Constantes.URL_BASE_CONDUCTOR + "Login.php", method: .post ,parameters: parameters)
                        .validate(statusCode: 200..<300)
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                if let value = response.result.value {
                                    let json = JSON(value)
                                    let id = json["conductor_id"].int!
                                    let nombre = json["conductor_nombre"].string!
                                    let equipo = json["conductor_equipo"].string!
                                    if(id != 0){
                                        if(equipo != "" && equipo != Constantes.DEVICE_APPLE_ID){
                                            Util.showToast(view: self.view,message: "Usuario activo en otro dispositivo")
                                        }
                                        else{
                                            Constantes.DEVICE_APPLE_ID = UIDevice.current.identifierForVendor!.uuidString
                                            Constantes.conductor.id = id
                                            Constantes.conductor.activo = true
                                            Constantes.conductor.nick = usuario!
                                            UserDefaults.standard.set(id, forKey: "idUsuario")
                                            UserDefaults.standard.set(usuario, forKey: "nickUsuario")
                                            UserDefaults.standard.set(self.txtPassword.text, forKey: "claveUsuario")
                                            UserDefaults.standard.set(nombre, forKey: "nombreUsuario")
                                            if(Constantes.conductor.recordarSesion){
                                                UserDefaults.standard.set(1, forKey: "recordar")
                                            }
                                            else{
                                                UserDefaults.standard.set(0, forKey: "recordar")
                                            }
                                            //self.modEstadoMovil( estado: "1")
                                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            let viewCtrl = storyboard.instantiateViewController(withIdentifier: "containerController")
                                            viewCtrl.modalPresentationStyle = .fullScreen
                                            viewCtrl.modalTransitionStyle = .crossDissolve
                                            self.present(viewCtrl, animated: true, completion: nil)
                                            //var backgroundTask = BackgroundTask()
                                            //backgroundTask.startBackgroundTask()
                                            
                                        }
                                    }
                                    else if (id == 0){
                                        Util.showToast(view: self.view,message: "Usuario y/o contraseña no coinciden")
                                    }
                                }
                                break
                            case .failure( _):
                                Util.showToast(view: self.view,message: "Ocurrio un error en el servidor")
                                break
                            }
                        }
            }
    
            
            func modEstadoMovil(estado:String){
                let conductor = Constantes.conductor.id
                let equipo = Constantes.DEVICE_APPLE_ID
                let parameters: [String: AnyObject] = ["conductor": conductor as AnyObject, "estado": estado as AnyObject, "equipo": equipo as AnyObject];
                Alamofire.request(Constantes.URL_BASE_MOVIL + "ModEstadoMovil.php", method: .post,parameters: parameters)
                        .validate(statusCode: 200..<300)
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                if response.result.value != nil {
                                    
                                }
                                break
                            case .failure( _):
                                Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                                break
                            }
                }
            }
    
    
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
