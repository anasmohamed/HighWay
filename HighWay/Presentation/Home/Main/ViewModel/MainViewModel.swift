//
//  MainViewModel.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import Foundation



class MainViewModel {
    var serviceListViewModel : ServiceListViewModel!
    private var serviceDataAccess = ServiceDataAccess()
    
    init() {
        self.serviceListViewModel = ServiceListViewModel(serviceDataAccess: serviceDataAccess)
    }
    
}
