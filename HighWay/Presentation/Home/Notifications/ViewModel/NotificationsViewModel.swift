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
    
    
    var reloadTableView: Observable<[Notification]> = Observable([])
    
    
    func fetchData() {
        notificationsFirebaseManager.getNotifications { [weak self] (success, notifications) in
              
            if success!{
                  self?.notifications = notifications
              }
              
//              self?.isLoading = false
          }
      }
    func getData(index: Int) -> Notification {
        return notifications[index]
    }
}
