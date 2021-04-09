//
//  OrdersHistoryFirebaseManager.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
import FirebaseFirestore
class OrderHistoryFirebaseManager {
    let db = Firestore.firestore()


    func getOrders(completion:@escaping (Bool?,[Order]) -> Void)  {
        var orders = [Order]()
            db.collection("userOrders").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(false, orders)
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if document.data()["user_id"] as! String == UserDefaults.standard.string(forKey: "token")!{
                        let timestamp: Timestamp = document.data()["timestamp"] as! Timestamp
                        let order = Order(orderType: document.data()["type"] as! String, orderDataTime: timestamp.dateValue(), orderId: document.data()["id"] as! String, orderStatus: String(document.data()["status"] as! Int))
                            orders.append(order)}
                    }
                    completion(true, orders)
                }
            }
    }
}
