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
    override func viewDidLoad(){
        bindData()
    }
    
    
    @IBAction func cancelOrderBtnDidTapped(_ sender: Any) {
        
        
    }
    func bindData() {
       
        requestOrderViewModel.inserOrdrSuccess.bind { (order) in
            if order != nil
            {
                UserDefaults.standard.set("true", forKey: "requestOrder")
                self.navigateToMainViewController(order:order!)
            }else{
                
            }
        }
    }
    func navigateToMainViewController(order:Order) {
        let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
        let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.order = order
        self.present(homeViewController, animated: true, completion: nil)
    }
    @IBAction func sendRequestOrderBtnDidTapped(_ sender: Any) {
        requestOrderViewModel.updateDate(note: issueDescribeDetetailsTeextField.text!, addressText: addressText, price: 5.0, fuelOrderSize: "", fuelOrderDate: "", fuelOrderPrice: "", rated: false, status: "-1", type: "fuel", userId: "", timestamp: date, startLat: startLat, startLng: startLong, endLat: endLat, endLng: endLong,arriveAddress: arriveAddressText)
        requestOrderViewModel.sendOrderData()
    }
}
