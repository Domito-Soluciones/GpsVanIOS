//
//  TableViewCellProduccion.swift
//  DMT-Transfer
//
//  Created by Mac Mini i7 on 30-03-20.
//  Copyright © 2020 Domito. All rights reserved.
//

import UIKit

class TableViewCellProduccion: UITableViewCell {
    
var servicio:Servicio? {
        didSet {
            guard let aux = servicio else {return}
            let id = aux.id
            let fecha =  aux.fecha! + " " + aux.hora!
            let tarifa = "$ "+aux.tarifa!
            idLabel.text = tarifa
            fechaLabel.text = fecha
            tarifaLabel.text = id
        }
    }
    
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
    
    let tarifaLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(tarifaLabel)
        self.contentView.addSubview(fechaLabel)
        
        idLabel.widthAnchor.constraint(equalToConstant:150).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        idLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        idLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        
        tarifaLabel.widthAnchor.constraint(equalToConstant:150).isActive = true
        tarifaLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        tarifaLabel.leadingAnchor.constraint(equalTo:self.idLabel.trailingAnchor, constant:20).isActive = true
        tarifaLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        
        fechaLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
        fechaLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        fechaLabel.topAnchor.constraint(equalTo:self.tarifaLabel.bottomAnchor).isActive = true
        fechaLabel.leadingAnchor.constraint(equalTo:self.idLabel.trailingAnchor, constant:20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}

