//
//  MenuOption.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 28-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Historico
    case Produccion
    case Configuracion
    case Salir
    
    var description: String {
        switch self {
        case .Historico: return "Historico"
        case .Produccion: return "Producción"
        case .Configuracion: return "Configuración"
        case .Salir: return "Cerrar sesión"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Historico: return UIImage(named: "historial") ?? UIImage()
        case .Produccion: return UIImage(named: "produccion") ?? UIImage()
        case .Configuracion: return UIImage(named: "configuracion") ?? UIImage()
        case .Salir: return UIImage(named: "salir") ?? UIImage()
        }
    }
}
