//
//  Util.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import SwiftUI


class Util {
    
    static func showToast(view:UIView, message : String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 20.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    static func enviarNotificacion(id:String,titulo:String,subtitulo:String,cuerpo:String){
     
       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
       let content = UNMutableNotificationContent()
       content.title = titulo
       content.subtitle = subtitulo
       content.body = cuerpo
       content.sound = UNNotificationSound.default
       let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
       UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
       UNUserNotificationCenter.current().add(request) {(error) in
          if let error = error {
             print("Se ha producido un error: \(error)")
          }
       }
    }
    
    static func llamar(numero:String){
        if let url = URL(string: "tel://\(numero)"),
        UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                print("error")
       }
    }
    
    static func navigateWaze(latitude: Double, longitude: Double) {
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            let urlStr = String(format: "https://www.waze.com/ul?ll=\(latitude),\(longitude)&navigate=yes&zoom=17")
            UIApplication.shared.open(URL(string: urlStr)!)
        } else {
            UIApplication.shared.open(URL(string: "http://itunes.apple.com/us/app/id323229106")!)
        }
    }
    
    static func navigateGMaps(latitude: Double, longitude: Double){
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!)
        }
        else {
            print("Can't use comgooglemaps://");
        }
    }
    
   static func navegar(){
        var nav = UserDefaults.standard.string(forKey: "nav")
        if(nav == "google"){
            Util.navigateGMaps(latitude: -33.4377968, longitude: -70.6504451)
        }
        else {
            Util.navigateWaze(latitude: -33.4377968, longitude: -70.6504451)
        }
    }
    
    static func cancelar(){
        
    }

}

