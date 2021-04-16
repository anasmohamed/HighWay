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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainViewModel = MainViewModel()
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        setupCollectionView()
        serviceCollectionView.reloadData()
        setupChatImage()
        if UserDefaults.standard.string(forKey: "requestOrder") == "true"
        {
            itCanBeUsefulLbl.isHidden = true
            serviceCollectionView.isHidden = true
            orderStatusView.isHidden = false
        }else{
            itCanBeUsefulLbl.isHidden = false
            serviceCollectionView.isHidden = false
            orderStatusView.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    private func setupChatImage()
    {
        chatImage.layer.cornerRadius = 5
    }
    
}
