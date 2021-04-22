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
    @IBOutlet weak var userIconImage: UIImageView!
    @IBOutlet weak var orderTypeLbl: UILabel!
    
    @IBOutlet weak var noDriverDataYetLbl: UILabel!
    @IBOutlet weak var phoneIconImage: UIImageView!
    @IBOutlet weak var productPriceLbl: UILabel!
    var order : Order!
    override func viewDidLoad() {
        super.viewDidLoad()
        noDriverDataYetLbl.isHidden = true

        setupBackButton() 
        contuctUsView.layer.cornerRadius = 8
        contuctUsView.layer.borderWidth = 0.5
        contuctUsView.layer.borderColor = UIColor.lightGray.cgColor
        userPhoto.layer.cornerRadius = userPhoto.frame.width / 2
        navigationController!.navigationBar.barTintColor = .white
        navigationController!.navigationBar.tintColor = .black
        navigationItem.title = "Order details".localized
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 14)!]
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
       
        if order.notes.isEmpty
        {
            notesLbl.text = "There is no notes".localized
        }else{
            notesLbl.text = order.notes
        }
        if order.orderType == "towing" {
            productPriceLbl.isHidden = true
            timeOfRecieveFuelOrder.isHidden = true

            orderDetailsLbl.text = "i need towing".localized
            orderTypeLbl.text = "Car towing".localized
            userAddressLbl.text = "- User address : ".localized + "\(order.userAddress)"
            driverAddressLbl.text = "- Arrive address : ".localized + "\(order.arriveAddress)"
            servicePriceLbl.text = "Service price : ".localized + "\(order.orderPrice)BHD"
            totalPriceLbl.text = "Total price : ".localized + "\(order.orderPrice)BHD"
            
            
        }else if order.orderType == "battery"{
            productPriceLbl.isHidden = true
            timeOfRecieveFuelOrder.isHidden = true
            orderDetailsLbl.text = "i need a battary charge".localized
            orderTypeLbl.text = "Battery charge".localized
            userAddressLbl.text = "- User address : ".localized + "\(order.userAddress)"
//            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : ".localized + "\(order.orderPrice)BHD"
            totalPriceLbl.text = "Total price : ".localized + "\(order.orderPrice)BHD"

        }else if order.orderType == "fuel"{
            productPriceLbl.isHidden = false
            orderDetailsLbl.text = "-\(order.fuelOrderSize)"
            timeOfRecieveFuelOrder.text = "-\(order.fuelOrderDate)"
            orderTypeLbl.text = "Car fuel".localized
            userAddressLbl.text = "- User address : ".localized + "\(order.userAddress)"
//            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : ".localized + "\(order.orderPrice)BHD"
            productPriceLbl.text = "Product price : ".localized + "\(order.fuelOrderPrice)BHD"
            totalPriceLbl.text = "Total price : ".localized + "\(order.orderPrice + Double(order.fuelOrderPrice)!)BHD"
        }else{
            productPriceLbl.isHidden = true
            timeOfRecieveFuelOrder.isHidden = true

            orderDetailsLbl.text = order.notes
//            timeOfRecieveFuelOrder.text = "-\(order.fuelOrderDate)"
            orderTypeLbl.text = order.orderType
            userAddressLbl.text = "- User address : ".localized + "\(order.userAddress)"
//            driverAddressLbl.text = "- Arrive address : \(order.arriveAddress)"
            servicePriceLbl.text = "Service price : ".localized + "\(order.orderPrice)BHD"
//            productPriceLbl.text = "Product price : \(order.fuelOrderPrice)BHD"
            totalPriceLbl.text = "Total price : ".localized + "\(order.orderPrice + Double(order.fuelOrderPrice)!)BHD"
        }
        guard let driver = order.driver else {
            userName.isHidden = true
            userPhone.isHidden = true
            userPhoto.isHidden = true
            noDriverDataYetLbl.isHidden = false
            userIconImage.isHidden = true
            phoneIconImage.isHidden = true
            return
        }
        userName.isHidden = false
        userPhone.isHidden = false
        userPhoto.isHidden = false
        noDriverDataYetLbl.isHidden = true
        userName.text = driver.name
        userPhone.text = driver.phone
        userIconImage.isHidden = true
        phoneIconImage.isHidden = true
        userPhoto.sd_setImage(with: URL(string: driver.image), completed: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = fals
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setupBackButton() {
        let leftBackBtn = UIButton(type: .system)
        leftBackBtn.setImage(UIImage(named: "left-arrow")?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        leftBackBtn.sizeToFit()
        leftBackBtn.addTarget(self, action: #selector(self.navigateToMainViewController), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBackBtn);
        navigationController?.navigationBar.tintColor = .white
    }
    @objc func navigateToMainViewController()  {
        self.dismiss(animated: true, completion: nil)
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
