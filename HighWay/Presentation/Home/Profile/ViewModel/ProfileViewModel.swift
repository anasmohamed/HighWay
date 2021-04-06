//
//  ProfileViewModel.swift
//  HighWay
//
//  Created by no one on 05/04/2021.
//

import Foundation
class ProfileViewModel {
     var profileManuListViewModel : ProfileManuListViewModel!
    init() {
        self.profileManuListViewModel = ProfileManuListViewModel()
    }
}
class ProfileManuListViewModel {
    private var profileManuDataAccess = ProfileMenuDataAccess()
     var profileManuViewModels  = [ProfileMenuViewModel]()
    init() {
        populateManu()
    }
    func populateManu(){
        self.profileManuViewModels = profileManuDataAccess.getMenuItems()
    }
    
}
struct ProfileMenuViewModel {
    var name : String!
    var image : String!
}
struct ProfileMenuDataAccess {
    func getMenuItems() ->[ProfileMenuViewModel]
    {
        var profileMenuViewModels = [ProfileMenuViewModel]()
        profileMenuViewModels.append(ProfileMenuViewModel(name: "language", image: "language"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Ratings", image: "user-2"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Reset Password", image: "padlock"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Connect us", image: "dialogue"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Terms of use", image: "terms-and-conditions"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Privacy policy", image: "insurance"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Logout", image: ""))

        
        
        return profileMenuViewModels
    }
}
