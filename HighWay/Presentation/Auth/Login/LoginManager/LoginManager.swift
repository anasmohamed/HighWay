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
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
        }

    }
}
