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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
