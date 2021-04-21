//
//  OthersViewController.swift
//  HighWay
//
//  Created by Anas Mohamed on 18/04/2021.
//

import UIKit

class OthersViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var sendBtm: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
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
        cancelBtn.layer.cornerRadius = 8
        sendBtm.layer.cornerRadius = 8
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendBtnDidTapped(_ sender: Any) {
        requestOrderViewModel.updateOthresTitleAndDescription(title:titleTextField.text! , decsription: descriptionTextField.text!)
        switch requestOrderViewModel.credentialsInput() {
        
        case .Correct:
            requestOrderViewModel.updateDate(note: "\(titleTextField.text!)<BODY>\(descriptionTextField.text!)", addressText: addressText, price:servicePrice , fuelOrderSize: "", fuelOrderDate: "", fuelOrderPrice: "", rated: false, status: "-1", type: "others", userId: "", timestamp: date, startLat: startLat, startLng: startLong, endLat: endLat, endLng: endLong,arriveAddress: arriveAddressText)
            requestOrderViewModel.sendOrderData()
        case .Incorrect:
            return
        }
        
    }
    
    @IBAction func cancelBtnDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        requestOrderViewModel.isOtherTitleFieldHighlighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.titleTextField)!)}
        }
        
        requestOrderViewModel.isOtherDescriptionFieldHighlighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.descriptionTextField)!)}
        }
        
        //        requestOrderViewModel.getAppSettingsSuccess.bind{
        //            (appsettings) in
        //
        //            self.servicePrice = appsettings?.batteryPrice ?? 0.0
        //            self.servicCostLbl.text = "\(self.servicePrice)BHD"
        //        }
        
    }
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
    func navigateToMainViewController(order:Order) {
        let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
        let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        let viewC = homeViewController.viewControllers?.first as! MainViewController
        // will give single Navigation Controller on index 0
        viewC.isAddFeedbackViewController = true
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
    }
}
