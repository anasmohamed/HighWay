//
//  RatingFirbaseManager.swift
//  HighWay
//
//  Created by no one on 06/04/2021.
//

import Foundation
import FirebaseFirestore
class RatingFirbaseManager  {
    let db = Firestore.firestore()


    func getRatings(completion:@escaping (Bool?,[Rating]) -> Void)  {
        var ratings = [Rating]()
            db.collection("user_rate").getDocuments() { (querySnapshot, err) in
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
