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
    private var orderFirebaseManager = OrderFirebaseManager()

    var lastOrder: Observable<Order?> = Observable(nil)

    init() {
        self.serviceListViewModel = ServiceListViewModel(serviceDataAccess: serviceDataAccess)
    }
    func fetchOrder()  {
        orderFirebaseManager.getLast{(status,order) in
            if status {
                self.lastOrder.value = order
            }else{
                self.lastOrder.value = nil
            }
        }
    }
    
}
