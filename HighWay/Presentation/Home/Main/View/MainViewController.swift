//
//  MainViewController.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import UIKit

class MainViewController: UIViewController {
   
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    var mainViewModel : MainViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainViewModel = MainViewModel()
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        setupCollectionView()
        serviceCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
