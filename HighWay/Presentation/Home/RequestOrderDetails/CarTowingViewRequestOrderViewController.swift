//
//  CarTowingViewRequestOrderViewController.swift
//  HighWay
//
//  Created by Anas Mohamed on 18/04/2021.
//

import Foundation
import UIKit
class CarTowingViewRequestOrderViewController: UIViewController {
    @IBOutlet weak var serviceCostLbl: UILabel!
    @IBOutlet weak var sendRequestBtn: UIButton!
    @IBOutlet weak var issueDescribeDetetailsTeextField: UITextField!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    
    var requestOrderViewModel = RequestOrderDetailsViewModel()
    var startLat = 0.0
    var startLong = 0.0
    var endLat = 0.0
    var endLong = 0.0
    var addressText = ""
    var arriveAddressText = ""
    var date = Date()
    var servicePrice = 0.0
    var distance = 0.0
    override func viewDidLoad(){
        requestOrderViewModel.getAppSettings()
        bindData()
        cancelOrderBtn.layer.cornerRadius = 8
        sendRequestBtn.layer.cornerRadius = 8
    }
    
    
    @IBAction func cancelOrderBtnDidTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    func bindData() {
       
        requestOrderViewModel.inserOrdrSuccess.bind { (order) in
            if order != nil
            {
                self.navigateToMainViewController(order:order!)
            }else{
                
            }
        }
        requestOrderViewModel.getAppSettingsSuccess.bind{
            (appsettings) in
            
            self.servicePrice = appsettings?.minValue ?? 0.0
            self.serviceCostLbl.text = "\(self.servicePrice)BHD"
        }
    }
    func navigateToMainViewController(order:Order) {
        let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
        let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        let viewC = homeViewController.viewControllers?.first as! MainViewController
        // will give single Navigation Controller on index 0
//        viewC.isAddFeedbackViewController = true
        viewC.order = order

        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
    }
    @IBAction func sendRequestOrderBtnDidTapped(_ sender: Any) {
        requestOrderViewModel.updateDate(note: issueDescribeDetetailsTeextField.text!, addressText: addressText, price:servicePrice , fuelOrderSize: "", fuelOrderDate: "", fuelOrderPrice: "", rated: false, status: "0", type: "towing", userId: "", timestamp: date, startLat: startLat, startLng: startLong, endLat: endLat, endLng: endLong,arriveAddress: arriveAddressText,distance:distance )
        requestOrderViewModel.sendOrderData()
    }
}
