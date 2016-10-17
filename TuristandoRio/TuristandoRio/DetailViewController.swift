//
//  DetailViewController.swift
//  TuristandoRio
//
//  Created by Denilson Monteiro on 17/09/16.
//  Copyright © 2016 Infnet. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: ViewController, MKMapViewDelegate {
    //Tem que linkar apertando com o direito na mapView historyboard e levando o delegate ate a viewcontroller (botao amarelo)

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbTipo: UILabel!
    @IBOutlet weak var lbAvaliacao: UILabel!
    @IBOutlet weak var lbCheckIn: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var dicPlace:NSDictionary?
    var coordinatePlace:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dic = dicPlace {
            
            let name = dic["name"] as! String
            let description = dic["description"] as! String
            let address = dic["address"] as! String
            let image = dic["image"] as! String
            let tipo = dic["tipo"] as! String
            let avaliacao = dic["avaliacao"] as! String
            let check_in = dic["check_in"] as! String
            
            lbName.text = name
            lbDescription.text = description
            lbAddress.text = address
            lbTipo.text = tipo
            lbAvaliacao.text = avaliacao
            lbCheckIn.text = check_in
            imageView.image = UIImage(named: image)
            imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame) * 0.5
            imageView.clipsToBounds = true
            
            getGeolocation(address)
            btActionGeocoder()
            
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
                    pin.title = self.dicPlace!["name"] as? String
                    pin.subtitle = self.dicPlace!["address"] as? String
                    self.mapView.addAnnotation(pin)
                }
            }
        }
    }
    
    @IBAction func btActionLocation(sender: AnyObject) {
        if self.coordinatePlace != nil {
            //Dicionario que configura a navegação
            let lauchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            let placemark = MKPlacemark(coordinate: self.coordinatePlace!, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.openInMapsWithLaunchOptions(lauchOptions)
        }
    }
    
    func btActionGeocoder(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(lbAddress.text!) { (placemarks, error) in
            if let placemark:CLPlacemark = placemarks?[0] {
                let location = placemark.location
                if let coords:CLLocationCoordinate2D = location?.coordinate {
                    print("Latitude: \(coords.latitude) , Longitude: \(coords.longitude)")
                    
                    self.coordinatePlace = coords
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion(center: coords, span: span)
                    self.mapView.setRegion(region, animated: false)
                    
                    //Adiciona pin do ponto turistico
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coords
                    annotation.title = self.dicPlace!["name"] as? String
                    annotation.subtitle = self.dicPlace!["address"] as? String
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation) {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        
        annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return annotationView
    }
    
    @IBAction func estiloDeMapa(sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        if (index == 0) {
            self.mapView.mapType = .Standard
            
        } else if (index == 1) {
            self.mapView.mapType = .Satellite
            
        } else {
            self.mapView.mapType = .Hybrid
            
        }
    }

    @IBAction func barProximos(sender: UIButton) {
        //Faz a busca na área e apresenta no console os resultados
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "bar"
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) in
            
            if let sucesso = response {
                for item in sucesso.mapItems {
                    print(item.placemark.name)
                    
                    //Faz a marcação dos pins na tela.
                    let pin = MKPointAnnotation()
                    pin.coordinate = item.placemark.coordinate
                    pin.title = item.placemark.name
                    pin.subtitle = item.placemark.title
                    self.mapView.addAnnotation(pin)
                }
            } else {
                print("Deu erro!")
            }
        }
    }
    
    @IBAction func cafeProximos(sender: UIButton) {
        //Faz a busca na área e apresenta no console os resultados
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "café"
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) in
            
            if let sucesso = response {
                for item in sucesso.mapItems {
                    print(item.placemark.name)
                    
                    //Faz a marcação dos pins na tela.
                    let pin = MKPointAnnotation()
                    pin.coordinate = item.placemark.coordinate
                    pin.title = item.placemark.name
                    pin.subtitle = item.placemark.title
                    self.mapView.addAnnotation(pin)
                }
            } else {
                print("Deu erro!")
            }
        }
    }
    
    @IBAction func restauranteProximo(sender: UIButton) {
        //Faz a busca na área e apresenta no console os resultados
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "restaurante"
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) in
            
            if let sucesso = response {
                for item in sucesso.mapItems {
                    print(item.placemark.name)
                    
                    //Faz a marcação dos pins na tela.
                    let pin = MKPointAnnotation()
                    pin.coordinate = item.placemark.coordinate
                    pin.title = item.placemark.name
                    pin.subtitle = item.placemark.title
                    self.mapView.addAnnotation(pin)
                }
            } else {
                print("Deu erro!")
            }
        }
    }
    
    @IBAction func comercioProximo(sender: UIButton) {
        //Faz a busca na área e apresenta no console os resultados
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "mercado"
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) in
            
            if let sucesso = response {
                for item in sucesso.mapItems {
                    print(item.placemark.name)
                    
                    //Faz a marcação dos pins na tela.
                    let pin = MKPointAnnotation()
                    pin.coordinate = item.placemark.coordinate
                    pin.title = item.placemark.name
                    pin.subtitle = item.placemark.title
                    self.mapView.addAnnotation(pin)
                }
            } else {
                print("Deu erro!")
            }
        }
    }
    
    @IBAction func btFoto(sender: UIButton) {
        
        print("Que merda!!!")
        
    }

}
