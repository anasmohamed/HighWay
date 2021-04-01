//
//  LoginManager.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
import FirebaseAuth
class LoginManager {
    func loginWithCredentials(email:String,password:String, completionHandler: @escaping (User,Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            
        }

    }
}
