//
//  OrdersHistoryViewModel.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
class OrdersHistoryViewModel {
    private var orderHistoryFirebaseManager = OrderHistoryFirebaseManager()
    private var orders: [Order] = [Order]()
    {
        didSet{
            orders.sort{(e1,e2)in
                e1.orderDataTime > e2.orderDataTime
                
            }
            reloadTableView.value = orders
        }
    }
    var numberOfItems: Int {
          return orders.count
      }
    
    
    var reloadTableView: Observable<[Order]> = Observable([])
    
    
    func fetchData() {
        orderHistoryFirebaseManager.getOrders { [weak self] (success, orders) in
              
            if success!{
                  self?.orders = orders
              }
              
//              self?.isLoading = false
          }
      }
    func getData(index: Int) -> Order {
        return orders[index]
    }
}
