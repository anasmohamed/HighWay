//
//  OrderHistroyViewController.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import UIKit

class OrdersHistroyViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var ordersHistoryTableView: UITableView!
    
    
    let orderHistoryViewModel = OrdersHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersHistoryTableView.delegate = self
        ordersHistoryTableView.dataSource = self
        setupTableView()
        bindData()
        fetchData()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "Cairo-Regular", size: 17), size: 17)]

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // Do any additional setup after loading the view.
    }
    override func willMove(toParent parent: UIViewController?) {
      
    }
    func bindData() {
        orderHistoryViewModel.reloadTableView.bind {_ in
            
            self.ordersHistoryTableView.reloadData()
        }}
    func fetchData() {
        orderHistoryViewModel.fetchData()
    }
    func setupTableView() {
        ordersHistoryTableView.register(UINib(nibName: "OrdersHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersHistoryTableViewCell")
        ordersHistoryTableView.backgroundColor = UIColor.init(red:234.0/255.0 , green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryViewModel.numberOfItems
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToOrderDetails(order: orderHistoryViewModel.getData(index: indexPath.row))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersHistoryTableViewCell", for: indexPath) as! OrdersHistoryTableViewCell
        cell.item = orderHistoryViewModel.getData(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func navigateToOrderDetails(order: Order)
    {
        let orderHistoryMapViewStroyboard = UIStoryboard.init(name: "OrderHistoryMapView", bundle: nil)
        let orderHistoryMapViewController = orderHistoryMapViewStroyboard.instantiateViewController(withIdentifier: "OrderHistoryMapViewController")
        as! OrderHistoryMapViewController
        orderHistoryMapViewController.order = order
        orderHistoryMapViewController.modalPresentationStyle = .fullScreen
        self.present(orderHistoryMapViewController, animated: true, completion: nil)
        
    }
}
