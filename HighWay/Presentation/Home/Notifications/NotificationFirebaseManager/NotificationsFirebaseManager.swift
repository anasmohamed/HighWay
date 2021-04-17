//
//  NotificationsFirebaseManager.swift
//  HighWay
//
//  Created by no one on 16/04/2021.
//

import Foundation
import FirebaseFirestore
class NotificationsFirebaseManager {
    let db = Firestore.firestore()
    func getNotifications(completion:@escaping (Bool?,[Notification]) -> Void)  {
        var notifications = [Notification]()
        db.collection("userNotifications").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false, notifications)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if document.data()["receiver_id"] as! String == UserDefaults.standard.string(forKey: "token")!{
                        let timestamp: Timestamp = document.data()["timestamp"] as! Timestamp
                        let order = Notification(action: document.data()["action"] as! String, orderId:document.data()["orderId"] as! String , read: document.data()["read"] as! Bool, reciverId: document.data()["receiver_id"] as! String, timestamp: timestamp.dateValue())
                        notifications.append(order)
                        completion(true, notifications)
                        
                    }
                }
            }
        }
    }
}

