//
//  RequestCarFuelOrderViewController.swift
//  HighWay
//
//  Created by no one on 14/04/2021.
//

import UIKit

class RequestCarFuelOrderViewController: UIViewController {
    @IBOutlet weak var timeOfReciveView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var timeOfRecieveTextFiel: UITextField!
    @IBOutlet weak var paymentTypeView: UIView!
    @IBOutlet weak var orderPriceDetailsView: UIView!
    @IBOutlet weak var timeOfReciveLbl: UILabel!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var sendOrderBtn: UIButton!
    @IBOutlet weak var itemstableView: UITableView!
    let dataPicker = UIDatePicker()
    var requestOrderViewModel = RequestOrderDetailsViewModel()
    var startLat = 0.0
    var startLong = 0.0
    var endLat = 0.0
    var endLong = 0.0
    var addressText = ""
    var fuelOrderPrice = 0.0
    var fuelOrderSize = ""
    var fuelOrderDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        itemstableView.delegate = self
        itemstableView.dataSource = self
        setupTableView()
        bindData()
        fetchData()
        createDatePicker()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "EEEE , d/MMM/yyyy"
        timeOfRecieveTextFiel.text = formatter.string(from: Date())
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendOrderDetailsBtnDidTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE , d/MMM/yyyy"
        let date = dateFormatter.date(from: timeOfRecieveTextFiel.text!)
        
        requestOrderViewModel.updateDate(note: notesTextField.text!, addressText: addressText, price: 5.0, fuelOrderSize: fuelOrderSize, fuelOrderDate: fuelOrderDate, fuelOrderPrice: String(fuelOrderPrice), rated: false, status: "-1", type: "fuel", userId: "", timestamp: date!, startLat: startLat, startLng: startLong, endLat: endLat, endLng: endLong)
        requestOrderViewModel.sendOrderData()
        
    }
    
    func createDatePicker(){
        timeOfRecieveTextFiel.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnPressed))
        toolbar.setItems([doneBtn], animated: true)
        timeOfRecieveTextFiel.inputAccessoryView = toolbar
        timeOfRecieveTextFiel.inputView = dataPicker
        dataPicker.datePickerMode = .date
    }
    @objc func doneBtnPressed()  {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "EEEE , d/MMM/yyyy"
        
        timeOfRecieveTextFiel.text = formatter.string(from: dataPicker.date)
        //        timeOfRecieveTextFiel.text = "\(dataPicker.date)"
        self.view.endEditing(true)
    }
    func setupTableView() {
        itemstableView.register(UINib(nibName: "ItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemsTableViewCell")
    }
    
    func fetchData() {
        requestOrderViewModel.fetchData()
    }
    
    
    @IBAction func cancelBtnDidTapped(_ sender: Any) {
    }
    func bindData() {
        requestOrderViewModel.reloadTableView.bind {_ in
            self.itemstableView.reloadData()
        }
        
        requestOrderViewModel.inserOrdrSuccess.bind { (order) in
            if order != nil
            {
                UserDefaults.standard.set("true", forKey: "requestOrder")
                self.navigateToMainViewController(order:order!)
            }else{
                
            }
        }
    }
    func navigateToMainViewController(order:Order) {
        let homeViewStoryboard = UIStoryboard.init(name: "MainView", bundle: nil)
        let homeViewController = homeViewStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.order = order
        self.present(homeViewController, animated: true, completion: nil)
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
        return requestOrderViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ItemsTableViewCell", for: indexPath)
            
            as! ItemsTableViewCell
        cell.item = requestOrderViewModel.getData(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
        }
        else{
            cell?.accessoryType = .checkmark
            
        }
        fuelOrderDate = timeOfRecieveTextFiel.text ?? ""
        fuelOrderPrice = requestOrderViewModel.getData(index: indexPath.row).fuelPrice
//        fuelOrderDate = requestOrderViewModel.getData(index: indexPath.row).date
        fuelOrderSize = requestOrderViewModel.getData(index: indexPath.row).size
    }
    
}
