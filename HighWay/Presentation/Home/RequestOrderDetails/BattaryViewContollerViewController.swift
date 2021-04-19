//
//  BattaryViewContollerViewController.swift
//  HighWay
//
//  Created by Anas Mohamed on 18/04/2021.
//

import UIKit

class BattaryViewContollerViewController: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var servicCostLbl: UILabel!
    @IBOutlet weak var notesTextField: UITextField!
    var requestOrderViewModel = RequestOrderDetailsViewModel()
    var startLat = 0.0
    var startLong = 0.0
    var endLat = 0.0
    var endLong = 0.0
    var addressText = ""
    var arriveAddressText = ""
    var date = Date()
    var servicePrice = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        requestOrderViewModel.getAppSettings()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtnDidTapped(_ sender: Any) {
    }
    @IBAction func sendBtnDidTapped(_ sender: Any) {
        requestOrderViewModel.updateDate(note: notesTextField.text!, addressText: addressText, price:servicePrice , fuelOrderSize: "", fuelOrderDate: "", fuelOrderPrice: "", rated: false, status: "-1", type: "battery", userId: "", timestamp: date, startLat: startLat, startLng: startLong, endLat: endLat, endLng: endLong,arriveAddress: arriveAddressText)
        requestOrderViewModel.sendOrderData()
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
        requestOrderViewModel.getAppSettingsSuccess.bind{
            (appsettings) in
            
            self.servicePrice = appsettings?.batteryPrice ?? 0.0
            self.servicCostLbl.text = "\(self.servicePrice)BHD"
        }
    }
    func navigateToMainViewController(order:Order) {
        let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
        let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.order = order
        self.present(homeViewController, animated: true, completion: nil)
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
