//
//  SignupManager.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class SignupManager{
    
    func signupWithEmailAndPassword(email:String,password:String, completionHandler: @escaping ([String]?,Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                completionHandler(nil,error)

            } else {
              print("User signs up successfully")
              let newUserInfo = Auth.auth().currentUser
              let token = Auth.auth().currentUser?.uid
              let email = newUserInfo?.email
                var user = [String]()
                user.append(token!)
                user.append(email!)
                
                completionHandler(user,nil)

            }
            
        }

    }
    func sendUserData(user:User,completion:@escaping (Error?,Bool?) -> Void)  {
        let db = Firestore.firestore()

        var userDict : [String:Any?]?
        userDict = ["currentOrder":user.currentOrder,
                    "email":user.email,
                     "hasOrder":0,
                     "id":nil,
                     "isActive":user.isActive,
                     "name":user.userName,
                     "password":user.password,
                     "phone":user.phoneNumber,
                     "token":user.deviceToken]
       
        
        db.collection("users").document(user.token).setData(userDict! as [String : Any]){ (err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(err,false)
            } else {
                UserDefaults.standard.set("true", forKey: "requestOrder")

                completion(nil,true)
            }
        }
    }

}
