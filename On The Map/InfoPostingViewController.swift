//
//  InfoPostingViewController.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/5/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class InfoPostingViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet var addresstextField:UITextField!
    @IBOutlet var whereareYou:UILabel!
    @IBOutlet var studying:UILabel!
    @IBOutlet var today:UILabel!
    @IBOutlet var onthemapButton:UIButton!
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var cancelButton:UIButton!
    @IBOutlet var mapView:MKMapView!
    @IBOutlet var mediaURL:UITextField!
    @IBOutlet var upperImageView:UIImageView!
    @IBOutlet var submitButton:UIButton!
    lazy var geocoder =  CLGeocoder()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        upperImageView.isHidden = true
        mediaURL.isHidden = true
        submitButton.isHidden = true
        mapView.delegate = self
        mapView.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getontheMap()
    {
        var address = addresstextField.text
        geocoder.geocodeAddressString(address!) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
    }
    
    @IBAction func cancelButtonPressed()
    {
        print("Cancel pressed")
        DispatchQueue.main.async {
            
        
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func submitButtonPressed()
    {
        UdacityClient.sharedInstance().mediaURL = mediaURL.text!
        UdacityClient.sharedInstance().mapString = addresstextField.text!
        //Call the method
        let parameters:[String:AnyObject] = ([UdacityClient.Methods.uniqueKey:UdacityClient.sharedInstance().userID, UdacityClient.Methods.firstName:UdacityClient.sharedInstance().firstName,UdacityClient.Methods.lastName:UdacityClient.sharedInstance().lastName,UdacityClient.Methods.mapString:UdacityClient.sharedInstance().mapString,UdacityClient.Methods.mediaURL:UdacityClient.sharedInstance().mediaURL,UdacityClient.Methods.lat:UdacityClient.sharedInstance().latitude,UdacityClient.Methods.long:UdacityClient.sharedInstance().longitude] as AnyObject) as! [String : AnyObject]
        ParseClient.sharedInstance().poststudentLocation(parameters: parameters) {(success,error) in
            
            if(success)
            {
                print("Posted student data")
                self.dismiss(animated: true, completion: nil)
                self.refreshData()
                
            }
            else
            {
                print(error)
            }
        }
    }
    

    func setUIEnabled(_ bool: Bool?)
    {
        if(bool == false)
        {
            addresstextField.isHidden = true
            whereareYou.isHidden = true
            studying.isHidden = true
            today.isHidden = true
            onthemapButton.isHidden = true
            imageView.isHidden = true
            mapView.isHidden = false
            upperImageView.isHidden = false
            mediaURL.isHidden = false
            submitButton.isHidden = false
        }
    }

    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        var annotations = [MKPointAnnotation]()
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            print( "Unable to Find Location for Address")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
               print("\(coordinate.latitude), \(coordinate.longitude)")
                //Get a coordinate in the MapKit language
                let lat = CLLocationDegrees(coordinate.latitude) 
                let long = CLLocationDegrees(coordinate.longitude)
                let mapCoord = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapCoord
                
                var span = MKCoordinateSpanMake(100, 100)
                var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
                self.mapView.setRegion(region, animated: true)
                
                annotations.append(annotation)
                self.mapView.addAnnotations(annotations)
                setUIEnabled(false)
                cancelButton.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                print("No Matching Location Found")
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}

extension UIViewController
{
    func refreshData()
    {
        ParseClient.sharedInstance().studentInfo = nil
    }
}


