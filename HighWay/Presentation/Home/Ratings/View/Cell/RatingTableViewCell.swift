//
//  RatingTableViewCell.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import UIKit
import Cosmos
class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingStarsView: CosmosView!
    
    @IBOutlet weak var ratingNamLbl: UILabel!
    @IBOutlet weak var ratingOwnerImage: UIImageView!
    
    var item = Rating(){
        didSet{
            ratingLbl.text = item.review
            ratingNamLbl.text = item.reviewerName
            ratingStarsView.rating = Double(item.rating)!
            ratingOwnerImage.image = UIImage(named: "")
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
