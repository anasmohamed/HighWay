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
        // Do any additional setup after loading the view.
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
