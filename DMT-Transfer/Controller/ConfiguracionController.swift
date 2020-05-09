//
//  ConfiguracionController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit

class ConfiguracionController: UIViewController {

    
    @IBOutlet weak var chkMaps: UISwitch!
    
    @IBOutlet weak var chkWaze: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        let aux = UserDefaults.standard.string(forKey:"nav")
        if(aux == "google"){
            chkMaps.isOn = true
            chkWaze.isOn = false
        }
        else{
            chkMaps.isOn = false
            chkWaze.isOn = true
        }
    }
    
    @IBAction func changeMaps(_ sender: Any) {
        if(chkMaps.isOn){
            chkWaze.isOn = false
            UserDefaults.standard.set("google", forKey: "nav")
            Util.showToast(view: self.view, message: "Navegación Google Maps seleccionada")
        }
        else{
            chkWaze.isOn = true
            UserDefaults.standard.set("waze", forKey: "nav")
            Util.showToast(view: self.view, message: "Navegación Waze seleccionada")
        }
    }
    
    @IBAction func changeWaze(_ sender: Any) {
        if(chkWaze.isOn){
            chkMaps.isOn = false
            UserDefaults.standard.set("waze", forKey: "nav")
            Util.showToast(view: self.view, message: "Navegación Waze seleccionada")
        }
        else{
            chkMaps.isOn = true
            UserDefaults.standard.set("google", forKey: "nav")
            Util.showToast(view: self.view, message: "Navegación Google Maps seleccionada")
        }
    }
    @objc func volver(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
        
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Configuración"
        let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
        navigationItem.leftBarButtonItem = imagen
    }

}


