//
//  SignupManager.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import Foundation
import FirebaseAuth

class SignupManager{
    
    func signupWithEmailAndPassword(email:String,password:String, completionHandler: @escaping (String?,Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                completionHandler(nil,error)

            } else {
              print("User signs up successfully")
              let newUserInfo = Auth.auth().currentUser
              let email = newUserInfo?.email
                completionHandler(email,nil)

            }
            
        }

    }
    

}
