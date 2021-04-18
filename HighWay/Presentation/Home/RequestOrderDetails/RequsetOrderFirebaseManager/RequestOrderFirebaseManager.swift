//
//  RequestOrderFirebaseManager.swift
//  HighWay
//
//  Created by no one on 14/04/2021.
//

import Foundation
import FirebaseFirestore

class RequestOrderFirebaseManager {
    let db = Firestore.firestore()
    
    func getFuelModel(completion:@escaping (Bool?,[FuelModel]) -> Void)  {
        var fuelModels = [FuelModel]()
        db.collection("fuelModel").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false, fuelModels)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let rating = FuelModel(fuelPrice:Double(document.data()["price"] as! String)!, size: document.data()["size"] as! String)
                    fuelModels.append(rating)
                }
                completion(true, fuelModels)
            }
        }
    }
    func sendOrderData(order:Order,completion:@escaping (Error?,Order?) -> Void)  {
        let timeInMiliseconds = String(Date().toMilliseconds())
        var orderDict : [String:Any]?
        switch order.orderType {
        case "fuel":
            orderDict = ["address":order.userAddress,
                         "fuelOrder":["date":order.fuelOrderDate,"fuelPrice":order.fuelOrderPrice,"size":order.fuelOrderSize],
                         "towingOrder":"",
                         "id":timeInMiliseconds,
                         "note":order.notes,
                         "price":order.orderPrice,
                         "rated":"false",
                         "startLat":order.startLat,
                         "startLng":order.startLong,
                         "status":Double(order.orderStatus)!,
                         "timestamp":order.orderDataTime ?? Date(),
                         "type":order.orderType,
                         "driver_id": nil,
                         "user_id":UserDefaults.standard.string(forKey: "token")!] as [String : Any?] as [String : Any]
        case "battery":
            orderDict = ["address":order.userAddress,
                         "fuelOrder":nil,
                         "towingOrder":nil,
                         "id":timeInMiliseconds,
                         "note":order.notes,
                         "price":order.orderPrice,
                         "rated":"false",
                         "startLat":order.startLat,
                         "startLng":order.startLong,
                         "status":Double(order.orderStatus)!,
                         "timestamp":order.orderDataTime ?? Date(),
                         "type":order.orderType,
                         "driver_id": nil,
                         "user_id":UserDefaults.standard.string(forKey: "token")!] as [String : Any?] as [String : Any]
        case "towing":
            orderDict = ["address":order.userAddress,
                         "fuelOrder":nil,
                         "towingOrder":["arriveAddress":order.arriveAddress,"distance":order.fuelOrderPrice,"endLat":order.endLat,"endLng":order.endLong],
                         "id":timeInMiliseconds,
                         "note":order.notes,
                         "price":order.orderPrice,
                         "rated":"false",
                         "startLat":order.startLat,
                         "startLng":order.startLong,
                         "status":Double(order.orderStatus)!,
                         "timestamp":order.orderDataTime ?? Date(),
                         "type":order.orderType,
                         "driver_id": nil,
                         "user_id":UserDefaults.standard.string(forKey: "token")!] as [String : Any?] as [String : Any]
        case "other":
            orderDict = ["address":order.userAddress,
                         "fuelOrder":nil,
                         "towingOrder":nil,
                         "id":timeInMiliseconds,
                         "note":order.notes,
                         "price":order.orderPrice,
                         "rated":"false",
                         "startLat":order.startLat,
                         "startLng":order.startLong,
                         "status":Double(order.orderStatus)!,
                         "timestamp":order.orderDataTime ?? Date(),
                         "type":order.orderType,
                         "driver_id": nil,
                         "user_id":UserDefaults.standard.string(forKey: "token")!] as [String : Any?] as [String : Any]
        default:
            break
        }
        
        db.collection("userOrders").document(timeInMiliseconds).setData(orderDict! as [String : Any]){ (err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(err,nil)
            } else {
                
                completion(nil,order)
            }
        }
    }
}
extension Date {
    
    func toMilliseconds() -> Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
    
    @available(iOS 13.0, *)
    init(milliseconds:Int) {
        self = Date().advanced(by: TimeInterval(integerLiteral: Int64(milliseconds / 1000)))
    }
}
