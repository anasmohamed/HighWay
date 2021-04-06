//
//  MainViewController.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import UIKit

class MainViewController: UIViewController {
    
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
        // Do any additional setup after loading the view.
    }
    
    
    private func setupChatImage()
    {
        chatImage.layer.cornerRadius = 5
    }
    
}
