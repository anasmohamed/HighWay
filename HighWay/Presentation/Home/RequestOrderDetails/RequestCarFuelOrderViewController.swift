//
//  RequestCarFuelOrderViewController.swift
//  HighWay
//
//  Created by no one on 14/04/2021.
//

import UIKit

class RequestCarFuelOrderViewController: UIViewController {
    @IBOutlet weak var timeOfReciveView: UIView!
    @IBOutlet weak var paymentTypeView: UIView!
    @IBOutlet weak var orderPriceDetailsView: UIView!
    @IBOutlet weak var timeOfReciveLbl: UILabel!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var sendOrderBtn: UIButton!
    @IBOutlet weak var itemstableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemstableView.delegate = self
        itemstableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendOrderDetailsBtnDidTapped(_ sender: Any) {
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RequestCarFuelOrderViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ItemsTableViewCell", for: indexPath)
        as! ItemsTableViewCell
        return cell
    }
    
    
    
}
