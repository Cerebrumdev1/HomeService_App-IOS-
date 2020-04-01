//
//  AppDelegate.swift
//  HomeServices
//
//  Created by Atinder Kaur on 3/20/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMaps
import Alamofire
import GooglePlaces
import GooglePlaces

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey(GoogleAPIKey)
        GoogleApi.shared.initialiseWithKey(GoogleAPIKey)
        GMSPlacesClient.provideAPIKey(GoogleAPIKey)
        registerForPushNotifications()
        set_nav_bar_color()
       
        FirebaseApp.configure()
        AllUtilies.CameraGallaryPrmission()
        setRootViewController()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func registerForPushNotifications()
     {
         UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
             (granted, error) in
             print("Permission granted: \(granted)")
             guard granted else { return }
             self.getNotificationSettings()
         }
    }
     
        func getNotificationSettings()
        {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                print("Notification settings: \(settings)")
            }
        }
        
        func set_nav_bar_color()
           {
               UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
               UINavigationBar.appearance().shadowImage = UIImage()
               UINavigationBar.appearance().tintColor = UIColor.black
               UINavigationBar.appearance().barTintColor = AppButtonColor.kOrangeColor
               UINavigationBar.appearance().isTranslucent = false
               UINavigationBar.appearance().clipsToBounds = false
            UINavigationBar.appearance().backgroundColor = AppButtonColor.kOrangeColor
               UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : (UIFont(name: "Helvetica Neue", size: 20))!, NSAttributedString.Key.foregroundColor: UIColor.black]
               
           }
    func setRootViewController()
     {
         if AppDefaults.shared.userID == ""
         {
             self.setRootView("LoginWithPhoneVC", storyBoard: "Main")
         }
         else
         {
            self.setRootView("SWRevealViewController", storyBoard: "Home")
         }
     }

}

