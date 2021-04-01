//
//  SignupViewController + TextFieldDelegate.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import Foundation
import UIKit
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        userNameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        userNameTextField.layer.borderWidth = 0
        phoneNumberTextField.layer.borderWidth = 0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
