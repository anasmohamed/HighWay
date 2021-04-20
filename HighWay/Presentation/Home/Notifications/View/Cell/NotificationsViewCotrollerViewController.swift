//
//  NotificationsViewCotrollerViewController.swift
//  HighWay
//
//  Created by no one on 16/04/2021.
//

import UIKit

class NotificationsViewCotrollerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var notificationsTableView: UITableView!
    var notificationViewModel = NotificationsViewModel()
    var order = Order()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        setupTableView()
        bindData()
        fetchData()
        // Do any additional setup after loading the view.
    }
    func bindData() {
        notificationViewModel.reloadTableView.bind {_ in
            
            self.notificationsTableView.reloadData()
        }
        notificationViewModel.order.bind{order in
            guard let order = order else {
                return
            }
            self.order = order
            let orderHistoryMapViewStroyboard = UIStoryboard.init(name: "OrderHistoryMapView", bundle: nil)
            let orderHistoryMapViewController = orderHistoryMapViewStroyboard.instantiateViewController(withIdentifier: "OrderHistoryMapViewController")
                as! OrderHistoryMapViewController
            orderHistoryMapViewController.isNotificationController = true
            orderHistoryMapViewController.order = order
            orderHistoryMapViewController.modalPresentationStyle = .fullScreen
            self.present(orderHistoryMapViewController, animated: true, completion: nil)
        }
    }
    
    func fetchData() {
        notificationViewModel.fetchData()
        
       
    }
    
    func setupTableView()  {
        notificationsTableView.register(UINib(nibName: "NotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationsTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell")
        as! NotificationsTableViewCell
        cell.item = notificationViewModel.getData(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderId = notificationViewModel.getData(index: indexPath.row).orderId
        notificationViewModel.updateOrderId(orderId: orderId)
        notificationViewModel.getOrder()
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  
    

}
