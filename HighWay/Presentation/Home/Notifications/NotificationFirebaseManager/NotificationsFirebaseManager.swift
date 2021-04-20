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
        db.collection("userNotifications").addSnapshotListener() { (querySnapshot, err) in
            notifications.removeAll()
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
    func getOrder(orderId:String,completion:@escaping (Bool,Order?) -> Void)
    {
        var order  : Order?
        
        db.collection("userOrders").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false, nil)
            } else {
                for document in querySnapshot!.documents {
                    
                    if document.data()["id"] as? String == orderId {
                        let towingOrder = document.data()["towingOrder"] as? [String:Any]
                        let fuelOrder = document.data()["fuelOrder"] as? [String:Any]
                        
                       
                            let timestamp: Timestamp = document.data()["timestamp"] as! Timestamp
                            order = Order(orderType: document.data()["type"] as! String, orderDataTime: timestamp.dateValue(),
                                          orderId: document.data()["id"] as! String,
                                          orderStatus: String(document.data()["status"] as! Int),
                                          startLat: document.data()["startLat"] as! Double,
                                          startLong: document.data()["startLng"] as! Double,
                                          endLat: towingOrder?["endLat"] as? Double ?? 0.0 ,
                                          endLong: towingOrder?["endLng"] as? Double ?? 0.0,
                                          fuelOrderDate: fuelOrder?["date"] as? String ?? "",
                                          fuelOrderPrice: String(fuelOrder?["fuelPrice"] as? Double ?? 0.0),
                                          fuelOrderSize: fuelOrder?["size"] as? String ?? "",
                                          userAddress: document.data()["address"] as? String ?? "",
                                          arriveAddress: towingOrder?["arriveAddress"] as? String ?? "",
                                          notes: document.data()["note"] as! String,
                                          orderPrice: document.data()["price"] as! Double,driver: nil)
                            completion(true,order)
                        }
                        
                    }
                }
            }
        }
        
    }


