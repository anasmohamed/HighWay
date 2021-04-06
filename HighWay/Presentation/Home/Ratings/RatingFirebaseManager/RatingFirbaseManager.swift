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
        let tasks = [Rating]()
            db.collection("user_rate").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(false, tasks)
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                    completion(true, tasks)
                }
            }
    }
}
