//
//  MapViewController.swift
//  HighWay
//
//  Created by no one on 08/04/2021.
//

import UIKit
import GoogleMaps
class OrderHistoryMapViewController: UIViewController {
    
    @IBOutlet weak var orderHistoryaMapVIew: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 2.0)
            
        orderHistoryaMapVIew.camera = camera
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = orderHistoryaMapVIew
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: -33.85, longitude: 151.20)
        marker2.title = "anasssssss"
        marker2.snippet = "Australia"
        marker2.map = orderHistoryaMapVIew
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
