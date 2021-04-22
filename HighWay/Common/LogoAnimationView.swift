//
//  LogoAnimationView.swift
//  HighWay
//
//  Created by Anas Mohamed on 22/04/2021.
//

import UIKit
import SwiftyGif

class LogoAnimationView: UIView {
    
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "1668641.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()
    let imageName = "17870-1"
    var image : UIImage?
    var imageView : UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
//        image = UIImage(named: imageName)
//        imageView = UIImageView(image: image!)
//        imageView!.frame = CGRect(x: 0, y: 0, width: 123, height: 200)
//        addSubview(imageView!)

//        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        logoGifImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        logoGifImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

//        logoGifImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
}
