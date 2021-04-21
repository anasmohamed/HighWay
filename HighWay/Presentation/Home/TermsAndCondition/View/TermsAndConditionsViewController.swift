//
//  TermsAndConditionsViewController.swift
//  HighWay
//
//  Created by no one on 12/04/2021.
//

import UIKit
import WebKit
class TermsAndConditionsViewController: UIViewController {

    @IBOutlet weak var termsAndCoditionWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndCoditionWebView.layer.cornerRadius = 5
        let myURL = URL(string:"https://highway-app.blogspot.com/p/terms-conditions.html")
        let myRequest = URLRequest(url: myURL!)
        termsAndCoditionWebView.load(myRequest)
        self.navigationItem.title = "Terms of use".localized
        setupBackButton()
        // Do any additional setup after loadin
        // Do any additional setup after loading the view.
    }
    func setupBackButton() {
        let leftBackBtn = UIButton(type: .system)
        leftBackBtn.setImage(UIImage(named: "left-arrow-4")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        leftBackBtn.sizeToFit()
        leftBackBtn.addTarget(self, action: #selector(self.navigateToMainViewController), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBackBtn);
        navigationController?.navigationBar.tintColor = .white
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
