//
//  RequestOrderMapViewApiManager.swift
//  HighWay
//
//  Created by no one on 13/04/2021.
//

import Foundation
import SwiftyJSON
class RequestOrderMapViewApiManager {
    let session = URLSession.shared
    
    func searchInLocation(name:String,complition:@escaping (CountryGeoLocation?,Error?) -> Void)  {
        let url = URL(string: "https://api.opencagedata.com/geocode/v1/json?key=375ea2f97ae54cbf8fd8486cb77a86e7&pretty=1&q=\(name)" +  "&countrycode=BH" + "&language=ar")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                                            // Handle error
                        complition(nil,error)
                } else if let data = data {
                    if let json = try? JSON(data: data) {
                        print(json)
                        print("json lat \(json["results"][0]["geometry"]["lat"].doubleValue)")
                        let countryGeolocation = CountryGeoLocation(latitude: json["results"][0]["geometry"]["lat"].doubleValue, longitude: json["results"][0]["geometry"]["lng"].doubleValue)
                        DispatchQueue.main.async {
                            complition(countryGeolocation,nil)

                        }
                    }                   // Handle successful response data
               
            }
            
        })
        task.resume()
    }
    
}
