//
//  ForgetPasswordViewModel.swift
//  HighWay
//
//  Created by no one on 02/04/2021.
//

import Foundation
class ForgetPasswordViewModel {
    private let forgetPasswordManager  = ForgetPasswordFirebaseManager()
    private weak var forgetPasswordProtocol : ForgetPasswordProtocol?
    private var email = ""
    
    
    var isEmailTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    var successMessage: Observable<String?> = Observable(nil)

//    init(forgetPasswordProtocol:ForgetPasswordProtocol) {
//        self.forgetPasswordProtocol = forgetPasswordProtocol
//    }
//
    //Here we update our model
    func updateEmail(email: String) {
        self.email = email
    }
    
    
    func sendEmailToResetPassword() {
        forgetPasswordManager.sendEmailToResetPassword(email: email) { [weak self] (message,error) in
            guard let error = error else {
                self?.successMessage.value = message

                return
            }
            
            
            self?.errorMessage.value = error.localizedDescription

        }
    }
    
    
    func credentialsInput() -> CredentialsInputStatus {

        if email.isEmpty {
            errorMessage.value = "email field is empty.".localized
            isEmailTextFieldHighLighted.value = true
            return .Incorrect
        }
        if !EmailValidation.isValidEmail(email)
        {
            errorMessage.value = "Enter Valid Email.".localized
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


