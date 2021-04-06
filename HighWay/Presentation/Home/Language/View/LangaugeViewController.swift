//
//  LangaugeViewController.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import UIKit

class LangaugeViewController: UIViewController {
    @IBOutlet weak var englishContainerView: UIView!
    @IBOutlet weak var arabicContainerView: UIView!
    @IBOutlet weak var langaugeContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        englishContainerView.layer.cornerRadius = 8
        arabicContainerView.layer.cornerRadius = 8
        langaugeContainerView.layer.cornerRadius = 8
    }
}
