//
//  ShadowForUIVIew.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
import UIKit
extension UIView{
    func cornerRadiusAndShodow()  {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.cornerRadius = 5
       }
}
