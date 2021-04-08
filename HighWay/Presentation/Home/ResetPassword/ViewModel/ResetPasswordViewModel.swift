//
//  ResetPasswordViewModel.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
class ResetPasswordViewModel {
    private let resetPasswordFirebaseManager  = ResetPasswordFirebaseManager()
    private weak var forgetPasswordProtocol : ForgetPasswordProtocol?
    private var oldPassword = ""
    private var newPassword = ""
    private var confirmPassword = ""
    private var email = ""

    
    var isOldPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isNewPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isConfirmPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)

    var errorMessage: Observable<String?> = Observable(nil)
    var successMessage: Observable<String?> = Observable(nil)

//    init(forgetPasswordProtocol:ForgetPasswordProtocol) {
//        self.forgetPasswordProtocol = forgetPasswordProtocol
//    }
//
    //Here we update our model
    func updatePassword(oldPassword: String,newPassword:String,confirmPassword:String,email:String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
        self.email = email
    }
    
    
    func changePassword() {
        resetPasswordFirebaseManager.changePassword(email: email,password: newPassword) { [weak self] (message,error) in
            if error != nil{
                self?.errorMessage.value = error?.localizedDescription

            }else{
                self?.successMessage.value = message

            }
        

        }
    }
    
    
    func credentialsInput() -> CredentialsInputStatus {

        if oldPassword.isEmpty {
            errorMessage.value = "old password field is empty."
            isOldPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        if newPassword.isEmpty {
            errorMessage.value = "old password field is empty."
            isOldPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        if confirmPassword.isEmpty {
            errorMessage.value = "old password field is empty."
            isOldPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
      
        return .Correct
    }
    
}
extension ResetPasswordViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}



