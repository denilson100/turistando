//
//  DetailViewController.swift
//  TuristandoRio
//
//  Created by Denilson Monteiro on 17/09/16.
//  Copyright © 2016 Infnet. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: ViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var dicPlace:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dic = dicPlace {
            
            let name = dic["name"] as! String
            let description = dic["description"] as! String
            let address = dic["address"] as! String
            let image = dic["image"] as! String
            
            lbName.text = name
            lbDescription.text = description
            lbAddress.text = address
            imageView.image = UIImage(named: image)
            
            getGeolocation(address)
            
            //Se usar ? no lugar de !
            //            if let nomeImage = image {
            //                imageView.image = UIImage(named: nomeImage)
            //            }
        }
        
    }
    
    func getGeolocation(textAddress:String) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textAddress) { (places:[CLPlacemark]?, error:NSError?) in
            
            if let place = places?[0] {
                
                if let location = place.location {
                    
                    let coord = location.coordinate
                    
                    let region = MKCoordinateRegionMakeWithDistance(coord, 500, 500)
                    self.mapView.setRegion(region, animated: true)
                    
                    //Adiciona um pin
                    let pin = MKPointAnnotation()
                    pin.coordinate = coord
                    self.mapView.addAnnotation(pin)
                }
            }
        }
    }

    @IBAction func btFoto(sender: UIButton) {
        
        print("Que merda!!!")
        
    }

}
