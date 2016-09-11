//
//  PlacesTableViewCell.swift
//  TuristandoRio
//
//  Created by Denilson Monteiro on 09/09/16.
//  Copyright © 2016 Infnet. All rights reserved.
//

import UIKit

//Nao esquecer de linkar esta classe com a cell customizada no custom class
class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbDescricao: UILabel!
    @IBOutlet weak var lbEndereco: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
