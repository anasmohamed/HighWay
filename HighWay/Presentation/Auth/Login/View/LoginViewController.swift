//
//  LoginViewController.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import UIKit
import Toast_Swift
class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var createAccountStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    var loginViewModel = LoginViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        bindData()
        setDelegates()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        createAccountStackView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.cornerRadiusAndShodow()
        self.addKeyboardObserver()

        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let signupStoryboard = UIStoryboard.init(name: "Signup", bundle: nil)
        let signupViewController = signupStoryboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(signupViewController, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    func setupButton()  {
        signInBtn.layer.cornerRadius = 5
    }
    
    @IBAction func signInBtnDidTapped(_ sender: Any) {
        //Here we ask viewModel to update model with existing credentials from text fields
        loginViewModel.updateCredentials(email: emailTextField.text!, password: passwordTextField.text!)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch loginViewModel.credentialsInput() {
        
        case .Correct:
            login()
        case .Incorrect:
            return
        }
    }
    
    
    
    @IBAction func forgetPasswordBtnDidTapped(_ sender: Any) {
      
        let forgetPasswordStoryboard = UIStoryboard.init(name: "ForgetPassword",bundle: nil)
        let forgetPasswordViewController = forgetPasswordStoryboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        forgetPasswordViewController.modalTransitionStyle = .crossDissolve
        forgetPasswordViewController.modalPresentationStyle = .overCurrentContext
        self.present(forgetPasswordViewController,animated:true,completion:nil)
        
        
    }
    
    func bindData() {

        
        loginViewModel.isEmailTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.emailTextField)!)}
        }
        
        loginViewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.passwordTextField)!)}
        }
        
        loginViewModel.errorMessage.bind {
            guard let errorMessage = $0 else { return }
            self.view.makeToast(errorMessage, duration: 3.0, position: .bottom)

        }
    }
    
    
    func login() {
        loginViewModel.login()
    }
    
    
    
    func setDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
    
}
