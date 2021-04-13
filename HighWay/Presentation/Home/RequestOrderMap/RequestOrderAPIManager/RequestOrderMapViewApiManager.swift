//
//  RequestOrderMapViewApiManager.swift
//  HighWay
//
//  Created by no one on 13/04/2021.
//

import Foundation
class RequestOrderMapViewApiManager {
    let session = URLSession.shared
    let url = URL(string: "...")!
    func searchInLocation(name:String,complition:@escaping (CountryGeoLocation?,Error?) -> Void)  {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                                            // Handle error
                        complition(nil,error)
                } else if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print(json)
                    }                   // Handle successful response data
                    complition(nil,nil)
               
            }
            
        })
        task.resume()
    }
    
}
