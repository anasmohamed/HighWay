//
//  RealLiveLocationFirebaseManager.swift
//  HighWay
//
//  Created by no one on 16/04/2021.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
class RealLiveLocationFirebaseManager {
    let rootRef = Database.database().reference()
    let db = Firestore.firestore()
    func getRealTimeLocation(completion:@escaping (Bool,[Double]?) -> Void) {
        var latLng = [Double]()

        let ref = rootRef.child("drivers_locations").child("nIJEtA6wyucXS0KnQ08wVX5BwlC3")
        ref.observe(.value, with: { (snapshot) in
                    print(snapshot)
                    guard let dictionary = snapshot.value as? [String : AnyObject] else {
                        return
                    }
            latLng.removeAll()
            print(dictionary["lat"])
            print("mylat ansa\\")
            latLng.append(dictionary["lat"] as! Double)
            latLng.append(dictionary["log"] as! Double)

            completion(true,latLng)

                }, withCancel: nil)

//        ref.observeSingleEvent(of: .childChanged, with: { (snapshot) in
//            print("anasSnapshot\(snapshot.value)")
//            if let userDict = snapshot.value as? [String:Any] {
//                //Do not cast print it directly may be score is Int not string
//                print(userDict["lat"])
//                print("mylat ansa\\")
//
//                completion(true,userDict["lat"] as! Double,userDict["lat"] as! Double)
//            }
//        })
    }
    func cancelOrder(orderId: String,completion:@escaping (Bool,Error?) -> Void)  {
        db.collection("userOrders").document(orderId).updateData(["status": -1]){err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false,err)
            } else {
                print("Document successfully updated")
                completion(true,nil)

            }
        }
    }
    
    func addFeedback(orderId: String,completion:@escaping (Bool,Error?) -> Void)  {
        db.collection("userOrders").document(orderId).updateData(["rated": true]){err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false,err)
            } else {
                print("Document successfully updated")
                completion(true,nil)

            }
        }
    }
    
}
