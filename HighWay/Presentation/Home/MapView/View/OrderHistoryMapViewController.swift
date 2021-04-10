//
//  MapViewController.swift
//  HighWay
//
//  Created by no one on 08/04/2021.
//

import UIKit
import GoogleMaps
class OrderHistoryMapViewController: UIViewController ,GMSMapViewDelegate {
    @IBOutlet weak var orderStatusLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var orderDateLbl: UILabel!
    @IBOutlet weak var addFeedbackBtn: UIButton!
    @IBOutlet weak var orderDetailsBtn: UIButton!
    @IBOutlet weak var orderHistoryaMapVIew: GMSMapView!
    var order : Order!
    let marker = GMSMarker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderHistoryaMapVIew.delegate = self
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM-dd-yyyy HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let dateString = formatter.string(from: order.orderDataTime)
        orderDateLbl.text = dateString
        addFeedbackBtn.layer.cornerRadius = 8
        orderStatusLbl.layer.borderWidth = 0.5
        orderStatusLbl.layer.cornerRadius = 8
        orderDetailsBtn.layer.cornerRadius = 8
        backBtn.layer.cornerRadius = 8
        orderStatusLbl.layer.borderColor = UIColor.lightGray.cgColor
        
//        self.orderHistoryaMapVIew.animate(with: camera)

    }
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func orderDetailsBtnDidTapped(_ sender: Any) {
        let orderDetailsStoryboard = UIStoryboard(name: "OrderDetails", bundle: nil)
        let orderDetailsViewController = orderDetailsStoryboard.instantiateViewController(withIdentifier: "OrderDetailesTableViewController") as! OrderDetailesTableViewController
        orderDetailsViewController.modalPresentationStyle = .fullScreen
        orderDetailsViewController.order = order
        self.present(orderDetailsViewController, animated: true,completion: nil)
        
        
    }
    
    
    @IBAction func addFeedbackBtnDidTapped(_ sender: Any) {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("order get lat \(order.startLat)")
        let bounds = GMSCoordinateBounds(coordinate:  CLLocationCoordinate2D(latitude: order.startLat, longitude:order.startLong), coordinate: CLLocationCoordinate2D(latitude:  order.endLat, longitude:order.endLong))
         let camera: GMSCameraUpdate = GMSCameraUpdate.fit(bounds)
//        let camera = GMSCameraPosition.camera(withLatitude: order.startLat, longitude: order.startLong, zoom: 15.0)
//        let cameraWithPadding: GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 100.0)
//        orderHistoryaMapVIew.camera = camera
        // Creates a marker in the center of the map.
        
        marker.position = CLLocationCoordinate2D(latitude: order.startLat, longitude:order.startLong)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = orderHistoryaMapVIew
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude:  order.endLat, longitude:order.endLong)
        marker2.title = "anasssssss"
        marker2.snippet = "Australia"
        marker2.map = orderHistoryaMapVIew
        orderHistoryaMapVIew.moveCamera(camera)
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
       UIView.animate(withDuration: 5.0, animations: { () -> Void in
       }, completion: {(finished) in
        mapView.animate(toZoom: 14)
         // Stop tracking view changes to allow CPU to idle.
        self.marker.tracksViewChanges = false
       })
     }
  
}
