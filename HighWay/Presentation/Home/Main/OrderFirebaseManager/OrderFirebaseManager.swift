//
//  OrderFirebaseManager.swift
//  HighWay
//
//  Created by no one on 16/04/2021.
//

import Foundation
import FirebaseFirestore
class OrderFirebaseManager {
    let db = Firestore.firestore()
    var driver : Driver?
    
    func getLast(completion:@escaping (Bool,Order?) -> Void)
    {
        var order  : Order?
        
        db.collection("userOrders").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false, nil)
            } else {
                for document in querySnapshot!.documents {
                    
                    if document.data()["user_id"] as? String == UserDefaults.standard.string(forKey: "token") &&   document.data()["status"] as! Int == 0 {
                        let towingOrder = document.data()["towingOrder"] as? [String:Any]
                        let fuelOrder = document.data()["fuelOrder"] as? [String:Any]
                        
                        self.getDriversForOrder(driverId: document.data()["driver_id"] as? String ?? ""){(sucess,driver)in
                            if sucess{
                                self.driver = driver
                            }
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
                                          orderPrice: document.data()["price"] as! Double,driver: self.driver ?? nil)
                            completion(true,order)
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
    func observerForNotifications(completion:@escaping (Bool?) -> Void)
    {
       
        db.collection("userNotifications").whereField("receiver_id", isEqualTo: UserDefaults.standard.string(forKey: "token")!)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                let cities = documents.map { $0["read"]! }
                for city in cities{
                    if city as! Int == 0{
                        completion(true)
                        
                    }else{
                        completion(false)

                    }
                }
                print("Current cities in CA: \(cities)")
            }
       
        
    }
}
