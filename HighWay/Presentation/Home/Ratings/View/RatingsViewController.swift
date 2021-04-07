//
//  RatingsViewController.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import UIKit

class RatingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var ratingTableView: UITableView!
    var ratingsListViewModel = RatingsListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingTableView.delegate = self
        ratingTableView.dataSource = self
        setupTableView()
        bindData()
        fetchData()
        ratingTableView.backgroundColor = UIColor.init(red:234.0/255.0 , green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    func setupTableView() {
        ratingTableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
    }
    
    func fetchData() {
        ratingsListViewModel.fetchData()
    }
    func bindData() {
        ratingsListViewModel.reloadTableView.bind {_ in
            self.ratingTableView.reloadData()
        }}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingsListViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath)
        as! RatingTableViewCell
        
        cell.item = ratingsListViewModel.getData(index: indexPath.row)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
    }
    
    
    
}
