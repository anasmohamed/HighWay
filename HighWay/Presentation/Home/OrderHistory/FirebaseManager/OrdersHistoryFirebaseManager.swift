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

    var driver : Driver?

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
                            let towingOrder = document.data()["towingOrder"] as? [String:Any]
                            let fuelOrder = document.data()["fuelOrder"] as? [String:Any]
                            self.getDriversForOrder(driverId: document.data()["driver_id"] as? String ?? ""){(sucess,driver)in
                                if sucess{
                                    self.driver = driver
                                    

                                        
                                }
                                let timestamp: Timestamp = document.data()["timestamp"] as! Timestamp
                                    let order = Order(orderType: document.data()["type"] as! String, orderDataTime: timestamp.dateValue(),
                                        orderId: document.data()["id"] as! String,
                                        orderStatus: String(document.data()["status"] as! Int),
                                        startLat: document.data()["startLat"] as! Double,
                                        startLong: document.data()["startLng"] as! Double,
                                        endLat: towingOrder?["endLat"] as? Double ?? 0.0 ,
                                        endLong: towingOrder?["endLng"] as? Double ?? 0.0,
                                        fuelOrderDate: fuelOrder?["date"] as? String ?? "",
                                        fuelOrderPrice: fuelOrder?["fuelPrice"] as? Double ?? 0.0,
                                        fuelOrderSize: fuelOrder?["size"] as? String ?? "",
                                        userAddress: document.data()["address"] as? String ?? "",
                                        arriveAddress: towingOrder?["arriveAddress"] as? String ?? "",
                                        notes: document.data()["note"] as! String,
                                        orderPrice: document.data()["price"] as! Double,driver: self.driver ?? nil)
                                orders.append(order)
                                completion(true, orders)
                                    
                            }
                     
                            
                             
                            
                        }
                    }
                }
            }
    }
    func getDriversForOrder(driverId:String,completion:@escaping (Bool,Driver?) -> Void)
    {
        var driver  = Driver()
        if !driverId.isEmpty{
        db.collection("drivers").document(driverId).getDocument{ (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(false, nil)
                } else {
                        
                    
                           
                    driver = Driver(image: document?.get("image") as! String, licenseImage: document?.get("licenseImage") as! String, phone: document?.get("phone") as! String, name: document?.get("name") as! String)
                    completion(true, driver)

                    }
                }
        }else{
            completion(false, nil)

        }
        
    }
    }

