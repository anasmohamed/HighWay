//
//  MainViewController.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var itCanBeUsefulLbl: UILabel!
    @IBOutlet weak var orderStatusView: UIView!
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    var mainViewModel : MainViewModel!
    var order : Order?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainViewModel = MainViewModel()
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        orderStatusView.layer.cornerRadius = 8
        setupCollectionView()
        serviceCollectionView.reloadData()
        setupChatImage()
        bind()
        fetchData() 
        
        // Do any additional setup after loading the view.
    }
    func fetchData()  {
        mainViewModel.fetchOrder()
    }
    func bind()  {
        mainViewModel.lastOrder.bind{ order in
            if order != nil{
                self.order = order
                self.itCanBeUsefulLbl.isHidden = true
                self.serviceCollectionView.isHidden = true
                self.orderStatusView.isHidden = false
            }else{
                self.itCanBeUsefulLbl.isHidden = false
                self.serviceCollectionView.isHidden = false
                self.orderStatusView.isHidden = true
            }
        }
    }
    private func setupChatImage()
    {
        chatImage.layer.cornerRadius = 5
    }
    
    @IBAction func orderDetailsBtnDidTapped(_ sender: Any) {
        
        
        let orderHistoryMapViewStroyboard = UIStoryboard.init(name: "OrderHistoryMapView", bundle: nil)
        let orderHistoryMapViewController = orderHistoryMapViewStroyboard.instantiateViewController(withIdentifier: "OrderHistoryMapViewController")
            as! OrderHistoryMapViewController
        orderHistoryMapViewController.order = order
        orderHistoryMapViewController.modalPresentationStyle = .fullScreen
        self.present(orderHistoryMapViewController, animated: true, completion: nil)
    }
    
    @IBAction func notificationBtnDidTappped(_ sender: Any) {
        let requestOrderMapViewStroyboard = UIStoryboard.init(name: "Notifications", bundle: nil)
        let requestOrderViewController = requestOrderMapViewStroyboard.instantiateViewController(withIdentifier: "NotificationsViewCotrollerViewController")
            as! NotificationsViewCotrollerViewController
        
        let myNavigationController = UINavigationController(rootViewController: requestOrderViewController)
        myNavigationController.modalPresentationStyle = .fullScreen
        self.present(myNavigationController, animated: true,completion: nil)
    }
}
