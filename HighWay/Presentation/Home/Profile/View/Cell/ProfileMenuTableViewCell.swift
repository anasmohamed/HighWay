//
//  ProfileMenuTableViewCell.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import UIKit

class ProfileMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemNameLeadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var menuItemName: UILabel!
    @IBOutlet weak var menuItemImage: UIImageView!
    
    @IBOutlet weak var logoutImage: UIImageView!
    var item : ProfileMenuViewModel?
    {
        didSet{
            self.menuItemName.text = item?.name
            if item?.name == "Logout"
            {
                menuItemNameLeadingConstrain.constant = 8
                logoutImage.image = UIImage(named:("power-button"))
            }
            self.menuItemImage.image = UIImage(named:(item?.image)!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
