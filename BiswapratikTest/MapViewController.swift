//
//  MapViewController.swift
//  BiswapratikTest
//
//  Created by navsoft-design on 11/01/18.
//  Copyright © 2018 navsoft-design. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var thisLocation = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = thisLocation.name
        showLocationInMap()
    }
    
    func showLocationInMap() {
        let camera = GMSCameraPosition.camera(withLatitude: thisLocation.latitude!, longitude: thisLocation.longitude!, zoom: 15.0)
        let mapViewGMS = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        mapViewGMS.settings.scrollGestures = false
        self.mapView.addSubview(mapViewGMS)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: thisLocation.latitude!, longitude: thisLocation.longitude!)
        marker.map = mapViewGMS
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
