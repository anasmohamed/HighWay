//
//  LoginViewModel.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
class LoginViewModel {
    private let loginManager  = LoginManager()
    private var user = User(){
        didSet{
            email = user.email
            password = user.password
        }
    }
    private var email = ""
    private var password = ""
    
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isEmailTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    var loginSuccess: Observable<[String]?> = Observable(nil)

    //
    //    init(loginManager: LoginManager) {
    //        self.loginManager = loginManager
    //    }
    
    //Here we update our model
    func updateCredentials(email: String, password: String, otp: String? = nil) {
        user.email = email
        user.password = password
    }
    
    
    func login() {
        loginManager.loginWithCredentials(email: email, password: password) { [weak self] (user,error) in
            guard let error = error else {
                self?.loginSuccess.value = user

                return
            }
            
            
            self?.errorMessage.value = error.localizedDescription
        }
    }
    
    
    func credentialsInput() -> CredentialsInputStatus {
        //        if email.isEmpty && password.isEmpty {
        //            credentialsInputErrorMessage.value = "Please provide username and password."
        //            return .Incorrect
        //        }
        if password.isEmpty {
            errorMessage.value = "Password should be 6 digits or more".localized
            isPasswordTextFieldHighLighted.value = true
            return .Incorrect
            
        }
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
extension LoginViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}
