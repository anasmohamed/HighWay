//
//  NotificationsViewModel.swift
//  HighWay
//
//  Created by no one on 16/04/2021.
//

import Foundation
class NotificationsViewModel {
    private var notificationsFirebaseManager = NotificationsFirebaseManager()
    private var notifications: [Notification] = [Notification]()
    {
        didSet{
            notifications.sort{(e1,e2)in
                e1.timestamp! > e2.timestamp!
                
            }
            reloadTableView.value = notifications
        }
    }
    var numberOfItems: Int {
          return notifications.count
      }
    
    var orderId = ""
    
    var reloadTableView: Observable<[Notification]> = Observable([])
    var order: Observable<Order?> = Observable(nil)

    func updateOrderId(orderId:String)  {
        self.orderId = orderId
    }
    func fetchData() {
        notificationsFirebaseManager.getNotifications { [weak self] (success, notifications) in
              
            if success!{
                  self?.notifications = notifications
              }
              
//              self?.isLoading = false
          }
      }
    func getOrder()
    {
        notificationsFirebaseManager.getOrder(orderId:orderId ){(status,order)
            in
            if status {
                self.order.value = order}
        }
    }
    
    func getData(index: Int) -> Notification {
        return notifications[index]
    }
}
