//
//  OrderDetailesTableViewController.swift
//  HighWay
//
//  Created by no one on 10/04/2021.
//

import UIKit
import SDWebImage
class OrderDetailesTableViewController: UITableViewController {
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var contuctUsView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeOfRecieveFuelOrder: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var orderDetailsLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    @IBOutlet weak var servicePriceLbl: UILabel!
    @IBOutlet weak var driverAddressLbl: UILabel!
    @IBOutlet weak var userAddressLbl: UILabel!
    @IBOutlet weak var orderTypeLbl: UILabel!
    
    @IBOutlet weak var productPriceLbl: UILabel!
    var order : Order!
    override func viewDidLoad() {
        super.viewDidLoad()
        contuctUsView.layer.cornerRadius = 8
        contuctUsView.layer.borderWidth = 0.5
        contuctUsView.layer.borderColor = UIColor.lightGray.cgColor
        userPhoto.layer.cornerRadius = userPhoto.frame.width / 2 
        if order.notes.isEmpty
        {
            notesLbl.text = "There is no notes"
        }else{
            notesLbl.text = order.notes
        }
        if order.orderType == "towing" {
            productPriceLbl.isHidden = true
            timeOfRecieveFuelOrder.isHidden = true

            orderDetailsLbl.text = "i need towing"
            orderTypeLbl.text = "Car towing"
            userAddressLbl.text = "- User address : \(order.userAddress)"
            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : \(order.orderPrice)BHD"
            totalPriceLbl.text = "Total price : \(order.orderPrice)BHD"
            
            
        }else if order.orderType == "battery"{
            productPriceLbl.isHidden = true
            timeOfRecieveFuelOrder.isHidden = true
            orderDetailsLbl.text = "i need a battary charge"
            orderTypeLbl.text = "Battery charge"
            userAddressLbl.text = "- User address : \(order.userAddress)"
//            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : \(order.orderPrice)BHD"
            totalPriceLbl.text = "Total price : \(order.orderPrice)BHD"

        }else if order.orderType == "fuel"{
            productPriceLbl.isHidden = false
            orderDetailsLbl.text = "-\(order.fuelOrderSize)"
            timeOfRecieveFuelOrder.text = "-\(order.fuelOrderDate)"
            orderTypeLbl.text = "Battery charge"
            userAddressLbl.text = "- User address : \(order.userAddress)"
//            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : \(order.orderPrice)BHD"
            productPriceLbl.text = "Product price : \(order.fuelOrderPrice)BHD"
            totalPriceLbl.text = "Total price : \(order.orderPrice + order.fuelOrderPrice)BHD"
        }else{
            productPriceLbl.isHidden = true
            timeOfRecieveFuelOrder.isHidden = true

            orderDetailsLbl.text = order.notes
//            timeOfRecieveFuelOrder.text = "-\(order.fuelOrderDate)"
            orderTypeLbl.text = order.orderType
            userAddressLbl.text = "- User address : \(order.userAddress)"
//            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : \(order.orderPrice)BHD"
//            productPriceLbl.text = "Product price : \(order.fuelOrderPrice)BHD"
            totalPriceLbl.text = "Total price : \(order.orderPrice + order.fuelOrderPrice)BHD"
        }
        userName.text = order.driver?.name
        userPhone.text = order.driver?.phone
        userPhoto.sd_setImage(with: URL(string: order.driver?.image ?? ""), completed: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = fals
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            print("nas 6")
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if !timeOfRecieveFuelOrder.isHidden
            {
                return 115
            }
        case 2:
            if !order.arriveAddress.isEmpty
            {
                return 175
            }
            else{
                return 140
            }
        case 4:
            if !productPriceLbl.isHidden
            {
                
                return 163
            }else{
                return  120
            }
        case 5:
            return 120
        case 6:
            return 70
        default:
            return 80
            
        }
        return 80
    }
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
