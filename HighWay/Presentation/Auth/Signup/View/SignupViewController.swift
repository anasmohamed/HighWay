//
//  SignupViewController.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var privacypolicyCheckBox: Checkbox!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var signupView: UIView!
    
    var signupViewModel = SignupViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        // Do any additional setup after loading the view.
    }
   

      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signupView.cornerRadiusAndShodow()
        
        self.addKeyboardObserver()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    @IBAction func privacyPolicyBtnDidTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func createAccountBtnDidTapped(_ sender: Any) {
        //Here we ask viewModel to update model with existing credentials from text fields
        signupViewModel.updateCredentials(username: emailTextField.text!, password: passwordTextField.text!,phoneNumber: phoneNumberTextField.text!,email: emailTextField.text!)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch signupViewModel.credentialsInput() {
        
        case .Correct:
            signup()
        case .Incorrect:
            return
        }
        
        
    }
    
    func setupButton()  {
        createAccountBtn.layer.cornerRadius = 8
    }
    
    func signup() {
        signupViewModel.signup()
    }
    
}
