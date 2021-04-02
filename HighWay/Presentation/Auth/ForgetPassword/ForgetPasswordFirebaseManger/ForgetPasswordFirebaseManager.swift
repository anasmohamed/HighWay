//
//  ForgetPasswordFirebaseManager.swift
//  HighWay
//
//  Created by no one on 02/04/2021.
//

import Foundation
import FirebaseAuth


class ForgetPasswordFirebaseManager  {
    func sendEmailToResetPassword(email:String, completionHandler: @escaping (String?,Error?) -> Void)  {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error as? NSError {
                completionHandler(nil,error)

            } else {
              
                completionHandler("A recovery link will be sent to email",nil)

            }
        }
    }
    
}
