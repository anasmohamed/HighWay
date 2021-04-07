//
//  ResetPasswordViewController.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import UIKit
import Toast_Swift
class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var saveNewPasswordBtn: UIButton!
    @IBOutlet weak var resetPasswordContainerView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var oldPasswordTextFiled: UITextField!
    
    let resetPasswordViewModel = ResetPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setDelegates()
        setupButton()
        setupContainerView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addKeyboardObserver()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    @IBAction func saveNewPasswordBtnDidTapped(_ sender: Any) {
        resetPasswordViewModel.updatePassword(oldPassword: oldPasswordTextFiled.text!, newPassword: newPasswordTextField.text!,confirmPassword: confirmPasswordTextField.text!)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch resetPasswordViewModel.credentialsInput() {
        
        case .Correct:
            resetPasswordViewModel.changePassword()
        case .Incorrect:
            return
        }
        

        
    }
    func setupButton()  {
        saveNewPasswordBtn.layer.cornerRadius = 8
    }
    func setupContainerView()  {
        resetPasswordContainerView.layer.cornerRadius = 8
    }
    func bindData() {
        resetPasswordViewModel.successMessage.bind {
            guard let successMessage = $0 else { return }
            LoadingIndicatorView.hide()
        
            var style = ToastStyle()

            // this is just one of many style options
            style.messageColor = .white
            style.backgroundColor = .green
            style.messageFont = UIFont(name:"" , size:20.0)!
            self.view.makeToast(successMessage, duration: 3.0, position: .bottom,style:style)


        }
        
        resetPasswordViewModel.isOldPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.oldPasswordTextFiled)!)}
        }
        
        
        resetPasswordViewModel.isNewPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.newPasswordTextField)!)}
        }
        resetPasswordViewModel.isConfirmPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField((self?.confirmPasswordTextField)!)}
        }
        
        resetPasswordViewModel.errorMessage.bind {
            LoadingIndicatorView.hide()

            guard let errorMessage = $0 else { return }
            
                var style = ToastStyle()

                // this is just one of many style options
                style.messageColor = .white
                style.backgroundColor = .red
                style.messageFont = UIFont(name:"Cairo-Regular" , size:20.0)!
                self.view.makeToast(errorMessage, duration: 3.0, position: .bottom,style:style)
            
        }
    }
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
    func setDelegates() {
        confirmPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        oldPasswordTextFiled.delegate = self
    }
}
