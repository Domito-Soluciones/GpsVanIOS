//
//  ContainerController.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit
import Alamofire

class ContainerController: UIViewController{
    
    var menuController: MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    
    func configureHomeController() {
        let homeController = HomeController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
            
        } else {
            // hide menu
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        
        animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .Historico:
            let controller = HistorialController()
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        case .Produccion:
            let controller = ProduccionController()
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        case .Configuracion:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "configuracionController")
            present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        case .Salir:
            Constantes.conductor.activo = false
            Constantes.conductor.estado = 0
            modEstadoMovil(estado: "0")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let viewCtrl = storyboard.instantiateViewController(withIdentifier: "loginController")
            viewCtrl.modalPresentationStyle = .fullScreen
            viewCtrl.modalTransitionStyle = .crossDissolve
            self.present(viewCtrl, animated: true, completion: nil)
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
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
    }}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
    
}

