//
//  ItemsTableViewCell.swift
//  HighWay
//
//  Created by no one on 14/04/2021.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
