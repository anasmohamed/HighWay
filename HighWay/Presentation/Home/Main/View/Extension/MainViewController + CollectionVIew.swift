//
//  MainViewController + CollectionVIew.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import Foundation
import UIKit
extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func setupCollectionView()
    {
        serviceCollectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.serviceListViewModel.serviceViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
        let serviceViewModel = mainViewModel.serviceListViewModel.serviceViewModels[indexPath.row]
        cell.item = serviceViewModel
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95.0, height: 75.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let requestOrderMapViewStroyboard = UIStoryboard.init(name: "RequestOrderMapView", bundle: nil)
        let requestOrderViewController = requestOrderMapViewStroyboard.instantiateViewController(withIdentifier: "RequestOrderMapViewController")
        as! RequestOrderMapViewController
        requestOrderViewController.orderType = mainViewModel.serviceListViewModel.serviceViewModels[indexPath.row].serviceName
        let myNavigationController = UINavigationController(rootViewController: requestOrderViewController)
        
        myNavigationController.modalPresentationStyle = .fullScreen
        self.present(myNavigationController, animated: true,completion: nil)
    }
}
