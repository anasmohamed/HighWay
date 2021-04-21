//
//  OrderHistoryMapViewModel.swift
//  HighWay
//
//  Created by no one on 17/04/2021.
//

import Foundation
class OrderHistoryMapViewModel {
    private var realLiveLocationFirebaseManager = RealLiveLocationFirebaseManager()
    var isOrderCanceldSuccessfully: Observable<Bool> = Observable(false)
    var isOrderCanceldError: Observable<Error?> = Observable(nil)
    var isAddFeedbackSuccessfully: Observable<Bool> = Observable(false)
    var isAddFeedbackError: Observable<Error?> = Observable(nil)
    var realLiveLatLng: Observable<[Double]?> = Observable(nil)
    var realLiveLatLngStatus: Observable<Bool> = Observable(false)
    var readNoftificationsObserver: Observable<Bool> = Observable(false)

    func cancelOrder(orderId:String)  {
        realLiveLocationFirebaseManager.cancelOrder(orderId:orderId){ (status,error) in
            
            if status{
                self.isOrderCanceldSuccessfully.value = true
            }else
            {
                self.isOrderCanceldError.value = error
            }
        }
    }
    func getRealTimeLocation(driverId:String)  {
        realLiveLocationFirebaseManager.getRealTimeLocation(driverId:driverId){(status,latLng) in
            self.realLiveLatLngStatus.value = status
            self.realLiveLatLng.value = latLng
        }
    }
    func readNotifications(orderId:String)  {
        realLiveLocationFirebaseManager.readNotification(orderId: orderId){
            (status,error) in
            self.readNoftificationsObserver.value = status
        }
    }
    func addFeedback(orderId:String)  {
        realLiveLocationFirebaseManager.addFeedback(orderId:orderId){ (status,error) in
            
            if status{
                self.isAddFeedbackSuccessfully.value = true
            }else
            {
                self.isAddFeedbackError.value = error
            }
        }
    }
}
