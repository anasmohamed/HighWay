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
        profileMenuViewModels.append(ProfileMenuViewModel(name: "language".localized, image: "language"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Ratings".localized, image: "user-2"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Reset Password".localized, image: "padlock"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Connect us".localized, image: "dialogue"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Terms of use".localized, image: "terms-and-conditions"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Privacy policy".localized, image: "insurance"))
        profileMenuViewModels.append(ProfileMenuViewModel(name: "Logout".localized, image: ""))

        
        
        return profileMenuViewModels
    }
}
