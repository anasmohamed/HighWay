//
//  RequestOrderViewModle.swift
//  HighWay
//
//  Created by no one on 14/04/2021.
//

import Foundation
class RequestOrderDetailsViewModel {
    private var requestOrderFirebaseManager = RequestOrderFirebaseManager()
    private var fuelModelsList: [FuelModel] = [FuelModel]()
    {
        didSet{
            reloadTableView.value = fuelModelsList
        }
    }
    var numberOfItems: Int {
          return fuelModelsList.count
      }
    
    var note = ""
    var addressText = ""
    var price = 0.0
    var fuelOrderSize = ""
    var fuelOrderDate = ""
    var fuelOrderPrice = "0.0"
    var fuelOrder = FuelModel()
    var rated = false
    var status = "-1"
    var type = "fuel"
    var userId = ""
    var timestamp : Date?
    var startLat = 0.0
    var startLong = 0.0
    var endLat = 0.0
    var endLng = 0.0
    var arriveAddress = ""
    
    func updateDate(note: String,addressText:String,price:Double,fuelOrderSize:String,fuelOrderDate: String,fuelOrderPrice:String,rated:Bool,status:String,type:String,userId:String,timestamp:Date?,startLat:Double,startLng:Double,endLat:Double,endLng:Double,arriveAddress:String) {
        
        
        self.addressText = addressText
        self.note = note
        self.price = price
        self.fuelOrderSize = fuelOrderSize
        self.fuelOrderDate = fuelOrderDate
        self.fuelOrderPrice = fuelOrderPrice
        self.rated = rated
        self.userId = ""
        self.status = status
        self.startLat = startLat
        self.startLong = startLng
        self.endLat = endLat
        self.endLng = endLng
        self.timestamp = timestamp
        self.type = type
        self.arriveAddress = arriveAddress
        
        
        
    }
    var reloadTableView: Observable<[FuelModel]> = Observable([])
    var inserOrdrSuccess: Observable<Order?> = Observable(nil)

    func fetchData() {
        
        requestOrderFirebaseManager.getFuelModel { [weak self] (success, fuelModelsList) in
              
            if success!{
                  self?.fuelModelsList = fuelModelsList
              }
              
//              self?.isLoading = false
          }
      }
    func sendOrderData()  {
    
        let order = Order(orderType: type, orderDataTime: timestamp, orderId: "", orderStatus: status, startLat: startLat, startLong: startLong, endLat: 0.0, endLong: 0.0, fuelOrderDate: fuelOrderDate, fuelOrderPrice: fuelOrderPrice, fuelOrderSize: fuelOrderSize, userAddress: addressText, arriveAddress: arriveAddress, notes: note, orderPrice: 5.0 , driver: nil)
        
        
        
        requestOrderFirebaseManager.sendOrderData(order: order){ (error ,order)in
            if error == nil
            {
                self.inserOrdrSuccess.value = order
            }else
            {
                self.inserOrdrSuccess.value = nil

            }
            
        }
    }
    func getData(index: Int) -> FuelModel {
        return fuelModelsList[index]
    }
}
