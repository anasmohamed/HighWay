//
//  LangaugeViewController.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import UIKit
import MOLH
class LangaugeViewController: UIViewController {
    @IBOutlet weak var englishContainerView: UIView!
    @IBOutlet weak var arabicLangaugeIndicatorView: UIView!
    @IBOutlet weak var englishLangaugeIndicatorView: UIView!

    @IBOutlet weak var arabicContainerView: UIView!
    @IBOutlet weak var langaugeContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        englishContainerView.layer.cornerRadius = 8
        arabicContainerView.layer.cornerRadius = 8
        langaugeContainerView.layer.cornerRadius = 8
        let englishTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleEnglishTap))

        englishContainerView.addGestureRecognizer(englishTapGestureRecognizer)
        let arabicTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleArabicTap))

        englishContainerView.addGestureRecognizer(arabicTapGestureRecognizer)
        if MOLHLanguage.currentAppleLanguage() == "ar"
        {
            englishLangaugeIndicatorView.isHidden = true
            arabicLangaugeIndicatorView.isHidden = false
        }else{
            englishLangaugeIndicatorView.isHidden = false
            arabicLangaugeIndicatorView.isHidden = true
        }
    }

    @objc func handleEnglishTap(){
        englishLangaugeIndicatorView.isHidden = false
        arabicLangaugeIndicatorView.isHidden = true
        MOLH.setLanguageTo("en")
        MOLH.reset(transition: .transitionCrossDissolve)
    }
  
    @objc func handleArabicTap(){
        englishLangaugeIndicatorView.isHidden = true
        arabicLangaugeIndicatorView.isHidden = false
        MOLH.setLanguageTo("ar")
        MOLH.reset(transition: .transitionCrossDissolve)
    }
}
