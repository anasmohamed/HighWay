//
//  ForgetPasswordViewModel.swift
//  HighWay
//
//  Created by no one on 02/04/2021.
//

import Foundation
class ForgetPasswordViewModel {
    private let forgetPasswordManager  = ForgetPasswordFirebaseManager()
    
    private var email = ""
    
    
    var isEmailTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    

    
    //Here we update our model
    func updateEmail(email: String) {
        self.email = email
    }
    
    
    func sendEmailToResetPassword() {
        forgetPasswordManager.sendEmailToResetPassword(email: email) { [weak self] (user,error) in
            guard let error = error else {
                return
            }
            
            self?.errorMessage.value = error.localizedDescription
        }
    }
    
    
    func credentialsInput() -> CredentialsInputStatus {

        if email.isEmpty {
            errorMessage.value = "email field is empty."
            isEmailTextFieldHighLighted.value = true
            return .Incorrect
        }
        if !EmailValidation.isValidEmail(email)
        {
            errorMessage.value = "Enter Valid Email."
            isEmailTextFieldHighLighted.value = true
            return .Incorrect
        }
      
        return .Correct
    }
    
}
extension ForgetPasswordViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}


