//
//  TableViewCellDetalle.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 30-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit

class TableViewCellDetalle: UITableViewCell {
    
    var pasajero:Pasajero? {
        didSet {
            guard let aux = pasajero else {return}
            let nombre =  aux.nombre
            let telefono = aux.telefono
            let destino = aux.destino
            
            nombreLabel.text  = nombre
            destinoLabel.text = destino
            if(telefono != ""){
                telefonoImageView.image = UIImage(named: "telefono")
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
    
    let telefonoImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(nombreLabel)
        self.contentView.addSubview(destinoLabel)
        self.contentView.addSubview(telefonoImageView)
        
        nombreLabel.widthAnchor.constraint(equalToConstant:150).isActive = true
        nombreLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        nombreLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        
        destinoLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
        destinoLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        destinoLabel.topAnchor.constraint(equalTo:self.nombreLabel.bottomAnchor).isActive = true
                        
        telefonoImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        telefonoImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
        telefonoImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        telefonoImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}

