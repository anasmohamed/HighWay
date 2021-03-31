//
//  ShadowForUIVIew.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
import UIKit
extension UIView{
    func cornerRadiusAndShodow(view:UIView)  {
           view.layer.shadowColor = UIColor.gray.cgColor
           view.layer.shadowOpacity = 1
           view.layer.shadowOffset = .zero
           view.layer.shadowRadius = 3
           view.layer.rasterizationScale = UIScreen.main.scale
           view.layer.cornerRadius = 5
       }
}
