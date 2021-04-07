//
//  ResetPassword + TextFieldDelegetes.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
import UIKit
extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        oldPasswordTextFiled.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        confirmPasswordTextField.layer.borderWidth = 0
        newPasswordTextField.layer.borderWidth = 0
        oldPasswordTextFiled.layer.borderWidth = 0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
