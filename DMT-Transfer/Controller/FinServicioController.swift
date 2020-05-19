//
//  FinServicioController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire

class FinServicioController: UIViewController {

    @IBOutlet weak var lblIdServicio: UILabel!
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblTarifa: UILabel!
    @IBOutlet weak var txtObservacion: UITextField!
    @IBOutlet weak var btnFinalizar: UIButton!
    
    public static var idServicio:String = ""
    public static var cliente:String = ""
    public static var fecha:String = ""
    public static var tarifa:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblIdServicio.text = FinServicioController.idServicio
        lblCliente.text = FinServicioController.cliente
        lblFecha.text = FinServicioController.fecha
        lblTarifa.text = FinServicioController.tarifa
        configureNavigationBar()
        Constantes.conductor.zarpeIniciado = false
        Constantes.conductor.pasajeroRecogido = false
        let conductor = Constantes.conductor.id
        let servicio = self.lblIdServicio.text
        let parameters: [String: AnyObject] = ["servicio": servicio as AnyObject, "conductor": conductor as AnyObject];
        Alamofire.request(Constantes.URL_BASE_MOVIL + "ModServicioMovil.php", method: .post,parameters: parameters)
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
    
    @objc func volver(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func configureNavigationBar() {
           navigationController?.navigationBar.barTintColor = .blue
           navigationController?.navigationBar.barStyle = .black
           //self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!];
           self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
           navigationItem.title = "Fin Servicio"
           let imagen = UIBarButtonItem(image: UIImage(named: "atras"), style: .plain, target: self, action: #selector(volver))
           navigationItem.leftBarButtonItem = imagen
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)

        
    }
    
    @IBAction func guardar(_ sender: Any) {
        let id = lblIdServicio.text
        let observacion = txtObservacion.text
        let parameters: [String: AnyObject] = ["idServicio": id as AnyObject, "observacion": observacion as AnyObject];
        Alamofire.request(Constantes.URL_BASE_SERVICIO + "AddObservacionServicio.php", method: .post,parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if response.result.value != nil {
                            self.finalizar()
                            Constantes.rootController?.obtenerServiciosProgramados()
                            Constantes.rootController?.viewWillAppear(true)
                        }
                        break
                    case .failure(let error):
                        print("Error : \(error)" )
                        Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                        break
                    }
        }      
    }
    func finalizar(){
        let id = FinServicioController.idServicio
        let parameters: [String: AnyObject] = ["id": id as AnyObject, "estado": "5" as AnyObject, "observacion": "" as AnyObject]
        Alamofire.request(Constantes.URL_BASE_SERVICIO + "ModEstadoServicio.php", method: .post,parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if response.result.value != nil {
                            self.dismiss(animated: true, completion: nil)
                            
                        }
                        break
                    case .failure(let error):
                        print("Error : \(error)" )
                        Util.showToast(view: self.view,message: "Ocurrio un error en el servidor ")
                        break
                    }
        }
    }

    
}

