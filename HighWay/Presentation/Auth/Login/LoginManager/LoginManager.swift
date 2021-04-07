//
//  LoginManager.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
import FirebaseAuth
class LoginManager {
    func loginWithCredentials(email:String,password:String, completionHandler: @escaping (String?,Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error as? NSError {
                completionHandler(nil,error)

            } else {
              print("User signs up successfully")
                let newUserInfo = authResult?.user
                let email = newUserInfo?.email
                completionHandler(email,nil)

            }
        }

    }
}
