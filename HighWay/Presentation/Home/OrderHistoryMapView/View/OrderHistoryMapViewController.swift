//
//  MapViewController.swift
//  HighWay
//
//  Created by no one on 08/04/2021.
//

import UIKit
import GoogleMaps
import Toast_Swift
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
    var viewModel = OrderHistoryMapViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderHistoryaMapVIew.delegate = self
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM-dd-yyyy HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        print("orderid anas\(order.orderId)")
        let dateString = formatter.string(from: order.orderDataTime)
        orderDateLbl.text = dateString
        addFeedbackBtn.layer.cornerRadius = 8
        cancelOrderBtn.layer.borderWidth = 0.5
        cancelOrderBtn.layer.cornerRadius = 8
        orderDetailsBtn.layer.cornerRadius = 8
        backBtn.layer.cornerRadius = 8
        cancelOrderBtn.layer.borderColor = UIColor.lightGray.cgColor
        bindData() 
        if order.orderStatus == "-1"
        {
            cancelOrderBtn.isEnabled = false
            cancelOrderBtn.setTitle("This order was canceled".localized, for: .normal)
            cancelOrderBtn.setTitleColor(UIColor.red, for: .normal)
            addFeedbackBtn.isHidden = true
            buttomConstraintOrderStatusVIew.constant = 20
            mapViewHieghtConstant.isActive = false
            mapViewHeightConstraintSecond.isActive = true
            
        }else if order.orderStatus == "0"
        {
            cancelOrderBtn.isEnabled = true
            cancelOrderBtn.setTitle("Cancel Order".localized, for: .normal)
            cancelOrderBtn.backgroundColor = UIColor.red
            cancelOrderBtn.setTitleColor(UIColor.white, for: .normal)
            addFeedbackBtn.isHidden = true
            buttomConstraintOrderStatusVIew.constant = 20
            mapViewHieghtConstant.isActive = false
            mapViewHeightConstraintSecond.isActive = true
        }else if order.rated{
            cancelOrderBtn.isEnabled = false
            cancelOrderBtn.setTitle("This order was completed".localized, for: .normal)
            cancelOrderBtn.setTitleColor(UIColor.green, for: .normal)
            addFeedbackBtn.isHidden = true
            buttomConstraintOrderStatusVIew.constant = 20
            mapViewHieghtConstant.isActive = false
            mapViewHeightConstraintSecond.isActive = true
        }else{
            cancelOrderBtn.isEnabled = false
            cancelOrderBtn.setTitle("This order was completed".localized, for: .normal)
            cancelOrderBtn.setTitleColor(UIColor.green, for: .normal)
            addFeedbackBtn.isHidden = false
            buttomConstraintOrderStatusVIew.constant = 67
            mapViewHieghtConstant.isActive = true
            mapViewHeightConstraintSecond.isActive = false
        }
        //        self.orderHistoryaMapVIew.animate(with: camera)
        
    }
    func bindData() {
        viewModel.isOrderCanceldSuccessfully.bind { (status) in
            LoadingIndicatorView.hide()

            if status {
                var style = ToastStyle()
                // this is just one of many style options
                style.messageColor = .white
                style.backgroundColor = UIColor.init(red: 220.0, green: 46.0, blue: 47.0, alpha: 1)
                style.messageFont = UIFont(name:"Cairo-Regular" , size:20.0)!
                self.view.makeToast("We are sorry, your order was cancel".localized, duration: 3.0, position: .bottom,style:style)
                let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
                let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "HomeTabBar")
                homeViewController.modalPresentationStyle = .fullScreen
                self.present(homeViewController, animated: true, completion: nil)
              
            }
            
        }
        viewModel.isOrderCanceldError.bind{ error in
            if error != nil{
                var style = ToastStyle()

                // this is just one of many style options
                style.messageColor = .white
                style.backgroundColor = UIColor.init(red: 220.0, green: 46.0, blue: 47.0, alpha: 1)
                style.messageFont = UIFont(name:"Cairo-Regular" , size:20.0)!
                self.view.makeToast(error?.localizedDescription, duration: 3.0, position: .bottom,style:style)
            }
            
        }
    }
    
    func cancelOrder()  {
        // create the alert
        let alert = UIAlertController(title: "", message: "".localized, preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Confirm".localized, style: UIAlertAction.Style.default, handler:{_ in
//            UserDefaults.standard.removeObject(forKey: "email")
//            let loginStoryboard = UIStoryboard.init(name: "LoginView", bundle: nil)
//            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.navigationController!.pushViewController(loginViewController, animated: true)
//            UserDefaults.standard.removeObject(forKey: "token")
//            UserDefaults.standard.removeObject(forKey: "email")
            LoadingIndicatorView.show()

            self.viewModel.cancelOrder(orderId: self.order.orderId)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func cancelOrderBtnDidTapped(_ sender: Any) {
        cancelOrder()
        
    }
    @IBAction func backBtnDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func orderDetailsBtnDidTapped(_ sender: Any) {
        let orderDetailsStoryboard = UIStoryboard(name: "OrderDetails", bundle: nil)
        let orderDetailsViewController = orderDetailsStoryboard.instantiateViewController(withIdentifier: "OrderDetailesTableViewController") as! OrderDetailesTableViewController
        orderDetailsViewController.modalPresentationStyle = .fullScreen
        orderDetailsViewController.order = order
        
        let myNavigationController = UINavigationController(rootViewController: orderDetailsViewController)
        myNavigationController.modalPresentationStyle = .fullScreen
        self.present(myNavigationController, animated: true,completion: nil)
        //        self.present(orderDetailsViewController, animated: true,completion: nil)
        
        
    }
    
    
    @IBAction func addFeedbackBtnDidTapped(_ sender: Any) {
        
        let addFeedbackViewStoryboard = UIStoryboard.init(name: "OrderHistoryMapView", bundle: nil)
        let addFeedbackViewController = addFeedbackViewStoryboard.instantiateViewController(withIdentifier: "AddFeedbackViewController") as! AddFeedbackViewController
        addFeedbackViewController.modalTransitionStyle = .crossDissolve
        addFeedbackViewController.modalPresentationStyle = .overCurrentContext
        addFeedbackViewController.orderId = order.orderId
        self.present(addFeedbackViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("order get lat \(order.startLat)")
        
        //
        // Creates a marker in the center of the map.
        
        marker.position = CLLocationCoordinate2D(latitude: order.startLat, longitude:order.startLong)
        marker.icon = UIImage(named: "placeholder-2")
        marker.title = "User Location".localized
        marker.map = orderHistoryaMapVIew
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude:  order.endLat, longitude:order.endLong)
        marker2.map = orderHistoryaMapVIew
        marker2.title = "Arrive point".localized
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
            mapView.animate(toZoom: 15)
            // Stop tracking view changes to allow CPU to idle.
            self.marker.tracksViewChanges = false
        })
    }
    
}

