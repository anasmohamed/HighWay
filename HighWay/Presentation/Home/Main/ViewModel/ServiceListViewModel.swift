//
//  ServiceListViewModel.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import Foundation
class ServiceListViewModel {
    var serviceViewModels  = [ServiceViewModel]()
    var serviceDataAccess : ServiceDataAccess
    init(serviceDataAccess: ServiceDataAccess) {
        self.serviceDataAccess = serviceDataAccess
        populateServices()
    }
    private func populateServices() {
        let services = serviceDataAccess.getAllService()
        self.serviceViewModels = services.map{service in
              return ServiceViewModel(service: service)
                                               
        }
    }
}
class ServiceViewModel {
    var serviceName : String!
    var serviceImage:String!
    init(service: Service) {
        self.serviceName = service.name
        self.serviceImage = service.image
    }
}

struct ServiceDataAccess {
    func getAllService() ->[Service]
    {
        var services = [Service]()
        services.append(Service(name: "Car towing".localized, image: "tow-truck-8"))
        services.append(Service(name: "Car fuel".localized, image: "fuel"))
        services.append(Service(name: "Battery".localized, image: "battery"))
        services.append(Service(name: "Others".localized, image: "ellipsis"))
        return services
    }
}
