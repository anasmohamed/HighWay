//
//  ProfileViewController.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import UIKit
import FirebaseAuth
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileManuTableView: UITableView!
    @IBOutlet weak var profileImageAndEmailView: UIView!
    
    var profileViewModel = ProfileViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileManuTableView.delegate = self
        profileManuTableView.dataSource = self
        setupTableView()
        setupEmailLbl()
        profileImageAndEmailView.layer.cornerRadius = 6
        profileManuTableView.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
    }
    
    func setupTableView()  {
        profileManuTableView.register(UINib(nibName: "ProfileMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileMenuTableViewCell")
    }
    func setupEmailLbl()
    {
        let email = UserDefaults.standard.string(forKey:"email")
        
        emailLbl.text = email
        
    }
    
    
}
extension ProfileViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.profileManuListViewModel.profileManuViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMenuTableViewCell", for: indexPath)
            as! ProfileMenuTableViewCell
        if indexPath.row != 6{
            cell.accessoryType = .disclosureIndicator
        }
        cell.item = profileViewModel.profileManuListViewModel.profileManuViewModels[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let languageStoryboard = UIStoryboard.init(name: "Language", bundle: nil)
            let langaugeViewController = languageStoryboard.instantiateViewController(withIdentifier: "LangaugeViewController") as! LangaugeViewController
            langaugeViewController.modalTransitionStyle = .crossDissolve
            langaugeViewController.modalPresentationStyle = .overCurrentContext
            self.present(langaugeViewController, animated: true, completion: nil)
        case 1:
            let ratingsStoryboard = UIStoryboard.init(name: "Ratings", bundle: nil)
            let ratingsViewController = ratingsStoryboard.instantiateViewController(withIdentifier: "RatingsViewController") as! RatingsViewController
            
            self.navigationController?.pushViewController(ratingsViewController, animated: true)
        case 2:
            let resetPasswordStoryboard = UIStoryboard.init(name: "ResetPassword", bundle: nil)
            let resetPasswordViewController = resetPasswordStoryboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
            resetPasswordViewController.modalTransitionStyle = .crossDissolve
            resetPasswordViewController.modalPresentationStyle = .overCurrentContext
            self.present(resetPasswordViewController, animated: true, completion: nil)
        case 6:
            logout()
        default:
            break
        }
    }
    func logout()  {
        // create the alert
        let alert = UIAlertController(title: "", message: "Did you want to logout?", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler:{_ in
            UserDefaults.standard.removeObject(forKey: "email")
            let loginStoryboard = UIStoryboard.init(name: "LoginView", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController!.pushViewController(loginViewController, animated: true)
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "email")

            do { try Auth.auth().signOut() }
            catch { print("already logged out")
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
