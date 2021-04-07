//
//  ResetPasswordFirebaseManager.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
import FirebaseAuth
class ResetPasswordFirebaseManager {
    func changePassword(password:String, completionHandler: @escaping (String?,Error?) -> Void)  {
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if error != nil
            {
                print("the error is \(error)")
                completionHandler(nil,error)
            }else{
                completionHandler("Password Changed Successfully",nil)

            }
            
        }
    }
   
}
