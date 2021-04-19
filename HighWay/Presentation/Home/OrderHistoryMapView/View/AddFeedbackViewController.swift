//
//  AddFeedbackViewController.swift
//  HighWay
//
//  Created by no one on 17/04/2021.
//

import UIKit
import Cosmos
import Toast_Swift
class AddFeedbackViewController: UIViewController {

    @IBOutlet weak var addFeedbackBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var addFeedbackView: UIView!
    var viewModel = OrderHistoryMapViewModel()
    var orderId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        addFeedbackBtn.layer.cornerRadius = 8
        closeBtn.layer.cornerRadius = 8
        addFeedbackView.layer.cornerRadius = 8
        bindData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeViewBtnDidTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func bindData() {
        viewModel.isAddFeedbackSuccessfully.bind { (status) in
            LoadingIndicatorView.hide()

            if status {
                
                let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
                let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
                let viewC = homeViewController.viewControllers?.first as! MainViewController
                // will give single Navigation Controller on index 0
                viewC.isAddFeedbackViewController = true
                homeViewController.modalPresentationStyle = .fullScreen
                self.present(homeViewController, animated: true, completion: nil)
              
            }
            
        }
        viewModel.isAddFeedbackError.bind{ error in
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
    @IBAction func addFeedbackBtnDidTapped(_ sender: Any) {
        if ratingView.rating == 0
        {
            var style = ToastStyle()
            // this is just one of many style options
            style.messageColor = .white
            style.backgroundColor = UIColor.init(red: 69.0/255.0, green: 81.0/255.0, blue: 174.0/255.0, alpha: 1)
            style.messageFont = UIFont(name:"Cairo-Regular" , size:20.0)!
            self.view.makeToast("Add rate first".localized, duration: 3.0, position: .bottom,style:style)
        }else{
            LoadingIndicatorView.show()
            self.viewModel.addFeedback(orderId: orderId!)
        }
        
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
