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
    
    @IBOutlet weak var containerView: UIView!
    var item = Rating(){
        didSet{
            if !item.review.isEmpty{
                ratingLbl.text = item.review
            }else{
                ratingLbl.text = "No Review Has been Written".localized
            }
            ratingNamLbl.text = item.reviewerName
            
            ratingStarsView.rating = Double(item.rating)!
            if item.image.isEmpty{
                
                ratingOwnerImage.image = UIImage(named: "user")}
            else{
                ratingOwnerImage.image = UIImage(named: item.image)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
