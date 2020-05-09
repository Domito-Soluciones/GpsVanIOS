//
//  TableViewCellHistorial.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 30-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit

class TableViewCellHistorial: UITableViewCell {
    
var servicio:Servicio? {
        didSet {
            guard let aux = servicio else {return}
            let id = aux.id
            let fecha =  aux.fecha! + " " + aux.hora!
            let empresa = aux.empresa
            let estado = aux.estado
            if(estado == "6"){
                estadoImageView.image = UIImage(named: "cerrar")
            }
            else {
                estadoImageView.image = UIImage(named: "finalizado")
            }
            idLabel.text = id
            fechaLabel.text = fecha
            empresaLabel.text = empresa
            
        }
    }
    
    
    let estadoImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let idLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    let fechaLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.frame = CGRect(x: 130, y: 30, width: 60, height: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    let empresaLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(estadoImageView)
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(empresaLabel)
        self.contentView.addSubview(fechaLabel)
        
        estadoImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        estadoImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        estadoImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
        estadoImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        idLabel.widthAnchor.constraint(equalToConstant:80).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        idLabel.leadingAnchor.constraint(equalTo:self.estadoImageView.trailingAnchor, constant:30).isActive = true
        idLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        
        empresaLabel.widthAnchor.constraint(equalToConstant:150).isActive = true
        empresaLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        empresaLabel.leadingAnchor.constraint(equalTo:self.idLabel.trailingAnchor, constant:10).isActive = true
        empresaLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        
        fechaLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
        fechaLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        fechaLabel.topAnchor.constraint(equalTo:self.empresaLabel.bottomAnchor).isActive = true
        fechaLabel.leadingAnchor.constraint(equalTo:self.idLabel.trailingAnchor, constant:20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}

