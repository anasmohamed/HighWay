//
//  NotificationsTableViewCell.swift
//  HighWay
//
//  Created by no one on 16/04/2021.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bellImageContainerView: UIView!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var orderStatusTextLbl: UILabel!
    @IBOutlet weak var orderStatusLbl: UILabel!
    
    var item = Notification() {
        didSet{
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "MM-dd-yyyy HH:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            
            let dateString = formatter.string(from: item.timestamp!)
            print("my date anas \(dateString)")
            dataLbl.text = dateString
            if item.action == "ORDER_COMPLETE"{
                orderStatusLbl.text = "Order completed"
                orderStatusTextLbl.text = "Your order completed successfully"
            }else if (item.action == "ORDER_CANCEL")
            {
                orderStatusLbl.text = "Order canceled"
                orderStatusTextLbl.text = "Sorry, your order was canceled"
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        bellImageContainerView.layer.borderWidth = 2
        bellImageContainerView.layer.borderColor = UIColor.init(red:2.0/255.0 , green:206.0/255.0 , blue: 119.0/255.0, alpha:1.0 ).cgColor
        bellImageContainerView.layer.cornerRadius = bellImageContainerView.frame.width / 2
        mainView.layer.cornerRadius = 8
//        containerView.layer.cornerRadius = cornerRadius
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        mainView.layer.shadowRadius = 5.0
        mainView.layer.shadowOpacity = 0.5
              
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
