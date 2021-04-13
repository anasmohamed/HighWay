//
//  RequestOrderMapViewModel.swift
//  HighWay
//
//  Created by no one on 13/04/2021.
//

import Foundation
class RequestOrderMapViewModel {
    private var requestOrderMapViewApiManager = RequestOrderMapViewApiManager()
    private var orders: CountryGeoLocation = CountryGeoLocation()
    
    
    
    private var countryName = ""
    
    func setCounryWith(countryName: String) {
        self.countryName = countryName
    }
    
    var countryGeolocation: Observable<CountryGeoLocation?> = Observable(nil)

    
    
    func fetchData() {
        requestOrderMapViewApiManager.searchInLocation(name: countryName) { [weak self] (coutryGeolocation,error) in
              
           
              
          }
      }
    
}
