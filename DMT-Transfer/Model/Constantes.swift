//
//  Constantes.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

struct Constantes{
      static let URL_BASE = "https://transfer.domitoapp.cl/source/httprequest/"
      static let URL_BASE_CONDUCTOR:String = URL_BASE + "conductor/"
      static let URL_BASE_MOVIL:String = URL_BASE + "movil/"
      static let URL_BASE_NOTIFICACION:String = URL_BASE + "notificacion/"
      static let URL_BASE_SERVICIO:String = URL_BASE + "servicio/"
      static let URL_BASE_LIQUIDACION:String = URL_BASE + "liquidacion/"
      static let URL_BASE_LOG:String = URL_BASE + "log/"
      static var DEVICE_APPLE_ID = ""
      static var conductor = Conductor()
      static var servicios:[Servicio] = []
}

