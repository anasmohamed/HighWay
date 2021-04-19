//
//  OrdersHistoryTableViewCell.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import UIKit

class OrdersHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var orderDateTimeLbl: UILabel!
    @IBOutlet weak var orderTypeLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var orderStatusColorView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    
    var item = Order()
    {
        didSet{
            orderIdLbl.text = "#\(item.orderId)"
            if item.orderType == "towing" || item.orderType == "fuel"{
                orderTypeLbl.text = "Car \(item.orderType)".localized
                
            }else if item.orderType == "others"{
                orderTypeLbl.text = item.orderType

            }else{
                orderTypeLbl.text = "Battery charge"

            }
            if item.orderStatus == "-1"
            {
                orderStatusColorView.backgroundColor = UIColor.init(red: 227.0/255.0, green: 20.0/255.0, blue: 19.0/255.0, alpha: 1)
            }else if item.orderStatus == "0"{
                orderStatusColorView.backgroundColor = UIColor.yellow
            }else{
                orderStatusColorView.backgroundColor = UIColor.init(red: 1.0/255.0, green: 203.0/255.0, blue: 114.0/255.0, alpha: 1)
            }
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "MM-dd-yyyy HH:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"

            let dateString = formatter.string(from: item.orderDataTime)
            print("my date anas \(dateString)")
            orderDateTimeLbl.text = dateString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 8
        orderStatusColorView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
