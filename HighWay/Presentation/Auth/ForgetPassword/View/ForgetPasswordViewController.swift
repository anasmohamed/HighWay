//
//  ResetPasswordViewController.swift
//  HighWay
//
//  Created by no one on 02/04/2021.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var sendEmailBtn: UIButton!
    
    var forgetPasswordViewModel = ForgetPasswordViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()  
        setDelegates() 
        bindData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetPasswordView.cornerRadiusAndShodow()
        self.addKeyboardObserver()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObserver()

    }
    @IBAction func sendEmailBtnDidTapped(_ sender: Any) {
        forgetPasswordViewModel.updateEmail(email: emailTextField.text!)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch forgetPasswordViewModel.credentialsInput() {
        
        case .Correct:
            sendEmailToResetPassword()
        case .Incorrect:
            return
        }
    }
    func setupButton()  {
        sendEmailBtn.layer.cornerRadius = 7
    }
    func bindData() {
        
        
        forgetPasswordViewModel.isEmailTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.emailTextField)!)}
        }
        
        
        
        forgetPasswordViewModel.errorMessage.bind {
            guard let errorMessage = $0 else { return }
            self.view.makeToast(errorMessage, duration: 3.0, position: .bottom)
            
        }
    }
    func sendEmailToResetPassword() {
        forgetPasswordViewModel.sendEmailToResetPassword()
    }
    
    
    func setDelegates() {
        emailTextField.delegate = self
    }
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
    
}
extension ForgetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
