//
//  ViewController.swift
//  TuristandoRio
//
//  Created by Denilson Monteiro on 09/09/16.
//  Copyright © 2016 Infnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var places = NSArray()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let placesPath = NSBundle.mainBundle().pathForResource("Places", ofType: "plist") {
            
            if let dic = NSDictionary(contentsOfFile: placesPath) {
                places = dic["places"] as! NSArray
                
                print(places)
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //cell customizada
        let cell = tableView.dequeueReusableCellWithIdentifier("CellPlace", forIndexPath: indexPath) as! PlacesTableViewCell//identificador
        
        let item = places[indexPath.row]
        let nome = item["name"] as! String
        let descricao = item["description"] as! String
        let endereco = item["address"] as! String
        let imagem = item["image"] as! String
        
        cell.lbTitulo.text = nome
        cell.lbDescricao.text = descricao
        cell.lbEndereco.text = endereco
        cell.imageCell.image = UIImage(named: imagem)
        
        return cell
    }

}

