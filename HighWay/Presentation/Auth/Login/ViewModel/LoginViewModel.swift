//
//  LoginViewModel.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
class LoginViewModel {
    private let loginManager :LoginManager
    private var user = User(){
        didSet{
            userName = user.userName
            password = user.password
        }
    }
    private var userName = ""
    private var password = ""
    
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    
    init(loginManager: LoginManager) {
        self.loginManager = loginManager
    }
    
    //Here we update our model
    func updateCredentials(username: String, password: String, otp: String? = nil) {
        user.userName = username
        user.password = password
    }
    
    
    func login() {
        loginManager.loginWithCredentials(username: userName, password: password) { [weak self] (error) in
            guard let error = error else {
                return
            }
            
            self?.errorMessage.value = error.localizedDescription
        }
    }
    
    
    func credentialsInput() -> CredentialsInputStatus {
        if userName.isEmpty && password.isEmpty {
            credentialsInputErrorMessage.value = "Please provide username and password."
            return .Incorrect
        }
        if userName.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty."
            isUsernameTextFieldHighLighted.value = true
            return .Incorrect
        }
        if password.isEmpty {
            credentialsInputErrorMessage.value = "Password field is empty."
            isPasswordTextFieldHighLighted.value = true
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
