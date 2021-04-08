//
//  ResetPasswordFirebaseManager.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
import FirebaseAuth
class ResetPasswordFirebaseManager {
    func changePassword(email:String,password:String, completionHandler: @escaping (String?,Error?) -> Void)  {
        let eMail = EmailAuthProvider.credential(withEmail: email, password: password)

        
        
        Auth.auth().currentUser?.reauthenticate(with: eMail){
            [weak self] (result,error)  in
            guard let error = error else
            {
                Auth.auth().currentUser?.updatePassword(to: password) { (error) in
                    if error != nil
                    {
                        print("the error is \(error)")
                        completionHandler(nil,error)
                    }else{
                        completionHandler("Password Changed Successfully",nil)

                    }
                    
                }
                return
            }
            completionHandler(nil,error)
            
        }
     
    }
   
}
