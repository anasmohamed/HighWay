//
//  ServiceCollectionViewCell.swift
//  HighWay
//
//  Created by no one on 03/04/2021.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceIconImage: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    
    var item : ServiceViewModel?
    {
        didSet {
            guard let item = item  else {
                return
            }
            serviceName?.text = item.serviceName
            if item.serviceName == "Car towing"
            {
                serviceIconImage.contentMode = .scaleAspectFill
            }
            serviceIconImage?.image = UIImage(named: item.serviceImage)

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        // Initialization code
    }
    
    func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
}
