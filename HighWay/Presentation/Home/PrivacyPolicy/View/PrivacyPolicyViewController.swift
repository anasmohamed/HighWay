//
//  PrivacyPolicyViewController.swift
//  HighWay
//
//  Created by no one on 12/04/2021.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController,WKUIDelegate  {
 
    @IBOutlet weak var privacyPolicyWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        privacyPolicyWebView.layer.cornerRadius = 5
        let myURL = URL(string:"https://highway-app.blogspot.com/p/privacy-policy.html")
        let myRequest = URLRequest(url: myURL!)
        privacyPolicyWebView.load(myRequest)
        self.navigationItem.title = "Privacy policy"

        setupBackButton()
        // Do any additional setup after loading the view.
    }
    func setupBackButton() {
        let leftBackBtn = UIButton(type: .system)
        leftBackBtn.setImage(UIImage(named: "left-arrow"), for: .normal)
        leftBackBtn.sizeToFit()
        leftBackBtn.addTarget(self, action: #selector(self.navigateToMainViewController), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBackBtn);
        navigationController?.navigationBar.tintColor = UIColor.init(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
    }
    @objc func navigateToMainViewController() {
        self.navigationController?.popViewController(animated: true)
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
