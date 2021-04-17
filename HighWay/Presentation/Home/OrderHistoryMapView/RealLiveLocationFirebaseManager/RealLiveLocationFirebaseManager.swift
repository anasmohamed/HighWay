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
    func getRealTimeLocation() {
        let ref = rootRef.child("drivers_locations").child("")
        ref.observeSingleEvent(of: .childChanged, with: { (snapshot) in
            if let userDict = snapshot.value as? [String:Any] {
                //Do not cast print it directly may be score is Int not string
                print(userDict["score"])
            }
        })
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
    
    
}
