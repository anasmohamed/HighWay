//
//  SignupViewController.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import UIKit
import Toast_Swift
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
        bindData()
        setDelegates()
        setupBackButton()
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
        print(privacypolicyCheckBox.isChecked)
        signupViewModel.updateCredentials(username: userNameTextField.text!, password: passwordTextField.text!,phoneNumber: phoneNumberTextField.text!,email: emailTextField.text!,isPrivacyPolicyChecked: privacypolicyCheckBox.isChecked)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch signupViewModel.credentialsInput() {
        
        case .Correct:
            LoadingIndicatorView.show()

            signup()
        case .Incorrect:
            return
        }
        
        
    }
    func bindData() {

        signupViewModel.signupSuccess.bind {
            LoadingIndicatorView.hide()

            guard let email = $0 else { return }
            let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
            let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "HomeTabBar")
            homeViewController.modalPresentationStyle = .fullScreen
            self.present(homeViewController, animated: true, completion: nil)
            UserDefaults.standard.set(email, forKey: "email")


        }
        signupViewModel.isEmailTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.emailTextField)!)}
        }
        
        signupViewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.passwordTextField)!)}
        }
        signupViewModel.isUsernameTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.userNameTextField)!)}
        }
        signupViewModel.isPhoneNumberTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.phoneNumberTextField)!)}
        }
        signupViewModel.errorMessage.bind {
            LoadingIndicatorView.hide()

            guard let errorMessage = $0 else { return }
            var style = ToastStyle()

            // this is just one of many style options
            style.messageColor = .white
            style.backgroundColor = .red
            style.messageFont = UIFont(name:"Cairo-Regular" , size:20.0)!
            self.view.makeToast(errorMessage, duration: 3.0, position: .bottom,style:style)
//            AlertController.showAllert(title: "Error", message: errorMessage, allertType: .error)
        }
    }
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
    func setupButton()  {
        createAccountBtn.layer.cornerRadius = 8
    }
    func setupBackButton() {
        let leftBackBtn = UIButton(type: .system)
        leftBackBtn.setImage(UIImage(named: "left-arrow"), for: .normal)
        leftBackBtn.sizeToFit()
        leftBackBtn.addTarget(self, action: #selector(self.navigateToMainViewController), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBackBtn);
        navigationController?.navigationBar.tintColor = UIColor.init(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
    }
    func signup() {
        signupViewModel.signup()
    }
    func setDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    @objc func navigateToMainViewController()  {
        self.navigationController?.popViewController(animated: true)
    }
}
