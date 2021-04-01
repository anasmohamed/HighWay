//
//  SignupViewModel.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import Foundation
class SignupViewModel {
    private let signupManager  = SignupManager()
    private var user = User(){
        didSet{
            userName = user.userName
            password = user.password
            email = user.email
            phoneNumber = user.phoneNumber
        }
    }
    private var userName = ""
    private var password = ""
    private var email = ""
    private var phoneNumber = ""
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
//    init() {
//
//    }
//    init(signupManager: SignupManager) {
//        self.signupManager = signupManager
//    }
    
    //Here we update our model
    func updateCredentials(username: String, password: String, phoneNumber: String,email: String) {
        user.userName = username
        user.password = password
        user.email = email
        user.phoneNumber = phoneNumber
    }
    
    
    func signup() {
        signupManager.signupWithEmailAndPassword(email: email, password: password) { [weak self] (user,error) in
            guard let error = error else {
                return
            }
            print(error)
            print(user)
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
extension SignupViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}
