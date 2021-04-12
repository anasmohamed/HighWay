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
    
    @IBOutlet weak var cancelOrderBtn: UIButton!
    @IBOutlet weak var mapViewHeightConstraintSecond: NSLayoutConstraint!
    @IBOutlet weak var mapViewHieghtConstant: NSLayoutConstraint!
    @IBOutlet weak var buttomConstraintOrderStatusVIew: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var orderDateLbl: UILabel!
    @IBOutlet weak var addFeedbackBtn: UIButton!
    @IBOutlet weak var orderDetailsBtn: UIButton!
    @IBOutlet weak var orderHistoryaMapVIew: GMSMapView!
    var order : Order!
    let marker = GMSMarker()
    var camera : GMSCameraPosition?
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
        cancelOrderBtn.layer.borderWidth = 0.5
        cancelOrderBtn.layer.cornerRadius = 8
        orderDetailsBtn.layer.cornerRadius = 8
        backBtn.layer.cornerRadius = 8
        cancelOrderBtn.layer.borderColor = UIColor.lightGray.cgColor
        if order.orderStatus == "-1"
        {
            cancelOrderBtn.isEnabled = false
            cancelOrderBtn.setTitle("This order was canceled", for: .normal)
            cancelOrderBtn.setTitleColor(UIColor.red, for: .normal)
            addFeedbackBtn.isHidden = true
            buttomConstraintOrderStatusVIew.constant = 20
            mapViewHieghtConstant.isActive = false
            mapViewHeightConstraintSecond.isActive = true
           
        }else if order.orderStatus == "0"
        {
            cancelOrderBtn.isEnabled = true
            cancelOrderBtn.setTitle("Cancel Order", for: .normal)
            cancelOrderBtn.backgroundColor = UIColor.red
            cancelOrderBtn.setTitleColor(UIColor.white, for: .normal)
            addFeedbackBtn.isHidden = true
            buttomConstraintOrderStatusVIew.constant = 20
            mapViewHieghtConstant.isActive = false
            mapViewHeightConstraintSecond.isActive = true
        }else{
            cancelOrderBtn.isEnabled = false
            cancelOrderBtn.setTitle("This order was completed", for: .normal)
            cancelOrderBtn.setTitleColor(UIColor.green, for: .normal)
            addFeedbackBtn.isHidden = false
            buttomConstraintOrderStatusVIew.constant = 67
            mapViewHieghtConstant.isActive = true
            mapViewHeightConstraintSecond.isActive = false
        }
        //        self.orderHistoryaMapVIew.animate(with: camera)
        
    }
    
    @IBAction func cancelOrderBtnDidTapped(_ sender: Any) {
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
     
        //
        // Creates a marker in the center of the map.
        
        marker.position = CLLocationCoordinate2D(latitude: order.startLat, longitude:order.startLong)
        marker.icon = UIImage(named: "placeholder-2")

        marker.map = orderHistoryaMapVIew
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude:  order.endLat, longitude:order.endLong)
        marker2.map = orderHistoryaMapVIew
        
        if !order.endLat.isZero{
            let bounds = GMSCoordinateBounds(coordinate:  CLLocationCoordinate2D(latitude: order.startLat, longitude:order.startLong), coordinate: CLLocationCoordinate2D(latitude:  order.endLat, longitude:order.endLong))
            let camera: GMSCameraUpdate = GMSCameraUpdate.fit(bounds)
            orderHistoryaMapVIew.moveCamera(camera)

        }else
        {
            camera = GMSCameraPosition.camera(withLatitude: order.startLat, longitude: order.startLong, zoom: 13.0,bearing: 270,
                                              viewingAngle: 45)
            orderHistoryaMapVIew.camera = camera!
        }
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
        }, completion: {(finished) in
            if !self.order.endLat.isZero{
                mapView.animate(toZoom: 14)}
            // Stop tracking view changes to allow CPU to idle.
            self.marker.tracksViewChanges = false
        })
    }
    
}
