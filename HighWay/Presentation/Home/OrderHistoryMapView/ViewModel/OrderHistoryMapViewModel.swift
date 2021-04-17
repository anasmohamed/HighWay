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
}
