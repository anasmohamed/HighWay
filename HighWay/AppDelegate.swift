//
//  AppDelegate.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces

let googleApiKey = "AIzaSyCriU-2hWd78P59qj035ySKwCTdQjW9TM8"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 17)!]
        for family: String in UIFont.familyNames {
                print("\(family)")
                for names: String in UIFont.fontNames(forFamilyName: family) {
                    print("== \(names)")
                }
            }
        UINavigationBar.appearance().titleTextAttributes = attributes
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyBFuCfU6gAQYq-Hxx7j6roE1liS9dYStsQ")
        GMSPlacesClient.provideAPIKey("AIzaSyBV788cfSiQGUjX2h5s2-0gCWvDKkT8fQ0")

        FirebaseApp.configure()

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

