//
//  MainViewController.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import UIKit
import Toast_Swift
import MOLH
class MainViewController: UIViewController {
    @IBOutlet weak var completeArabicTitleLbl: UILabel!
    @IBOutlet weak var timeOfOrder: UILabel!
    @IBOutlet weak var progressArabicTitleLbl: UILabel!
    @IBOutlet weak var orderDetailsBtn: UIButton!
    @IBOutlet weak var sentTitleLbl: UILabel!
    @IBOutlet weak var completeTitleLbl: UILabel!
    @IBOutlet weak var progressTitleLbl: UILabel!
    @IBOutlet weak var completeImageView: UIImageView!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var notificationRedCircle: UIView!
    @IBOutlet weak var circelImageView: UIImageView!
    @IBOutlet weak var progressCircleView: UIView!
    @IBOutlet weak var itCanBeUsefulLbl: UILabel!
    @IBOutlet weak var orderStatusView: UIView!
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    var mainViewModel : MainViewModel!
    var order : Order?
    var isAddFeedbackViewController = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainViewModel = MainViewModel()
    
        notificationRedCircle.layer.cornerRadius = notificationRedCircle.frame.width / 2
        notificationRedCircle.isHidden = true
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        orderStatusView.layer.cornerRadius = 8
        setupCollectionView()
        serviceCollectionView.reloadData()
        setupChatImage()
        bind()
        fetchData()
        circelImageView.layer.borderWidth = 2
        circelImageView.layer.cornerRadius = circelImageView.frame.width / 2
        circelImageView.layer.borderColor = UIColor.init(red: 162.0/255.0, green: 162.0/255.0, blue: 162.0/255.0, alpha: 1).cgColor
        progressCircleView.layer.borderColor = UIColor.init(red: 162.0/255.0, green: 162.0/255.0, blue: 162.0/255.0, alpha: 1).cgColor
        completeImageView.layer.borderWidth = 2
        completeImageView.layer.cornerRadius = circelImageView.frame.width / 2
        completeImageView.layer.borderColor = UIColor.init(red: 162.0/255.0, green: 162.0/255.0, blue: 162.0/255.0, alpha: 1).cgColor
        completeView.layer.borderColor = UIColor.init(red: 162.0/255.0, green: 162.0/255.0, blue: 162.0/255.0, alpha: 1).cgColor
        if isAddFeedbackViewController{
            var style = ToastStyle()
            // this is just one of many style options
            style.messageColor = .white
            style.backgroundColor = UIColor.init(red: 69.0/255.0, green: 81.0/255.0, blue: 174.0/255.0, alpha: 1)
            style.messageFont = UIFont(name:"Cairo-Regular" , size:20.0)!
            self.view.makeToast("You rate added succcessfully, thak you".localized, duration: 3.0, position: .top,style:style)
        }
        if MOLHLanguage.currentAppleLanguage() == "ar"
        {
            completeTitleLbl.isHidden = true
            progressTitleLbl.isHidden = true
            sentTitleLbl.isHidden = true
            completeArabicTitleLbl.isHidden = false
            progressArabicTitleLbl.isHidden = false
        }else{
            completeTitleLbl.isHidden = false
            progressTitleLbl.isHidden = false
            sentTitleLbl.isHidden = false
            completeArabicTitleLbl.isHidden = true
            progressArabicTitleLbl.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func fetchData()  {
        mainViewModel.fetchOrder()
        mainViewModel.observeNewNotifications()
    }
    func bind()  {
        mainViewModel.lastOrder.bind{ order in
            self.order = order
            
          
            if order != nil{
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "MM-dd-yyyy h:mm a"
                formatter.amSymbol = "AM"
                formatter.pmSymbol = "PM"
                
                let dateString = formatter.string(from: order!.orderDataTime)
                self.timeOfOrder.text = dateString
                self.itCanBeUsefulLbl.isHidden = true
                self.serviceCollectionView.isHidden = true
                self.orderStatusView.isHidden = false
            }else{
                self.itCanBeUsefulLbl.isHidden = false
                self.serviceCollectionView.isHidden = false
                self.orderStatusView.isHidden = true
            }
            
        }
        mainViewModel.notificationsObserver.bind{
            status in
            print(status)
            if status != nil{
            if status!
            {
                self.notificationRedCircle.isHidden = false
            }else{
                self.notificationRedCircle.isHidden = true
            }}
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
        orderHistoryMapViewController.isMainViewController = true
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
