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


    func getRatings(completion:@escaping (Bool?,[Rating]) -> Void)  {
        var ratings = [Rating]()
            db.collection("ordersHistory").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(false, ratings)
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let rating = Rating(rating: String(document.data()["rate"] as! Int), reviewerName: document.data()["name"] as! String, review: document.data()["note"] as! String, image: "")
                        ratings.append(rating)
                    }
                    completion(true, ratings)
                }
            }
    }
}
