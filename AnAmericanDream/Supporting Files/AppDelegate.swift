//
//  AppDelegate.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 03/02/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let locationManager = CLLocationManager()
    
    var hasAlreadyLaunched: Bool!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        locationManager.requestAlwaysAuthorization()
        // Override point for customization after application launch.
        
        //retrieve value from local store, if value doesn't exist then false is returned
        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        
        return true
    }
    
    func sethasAlreadyLaunched() {
        hasAlreadyLaunched = false
        UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
    }

    // MARK: UISceneSession Lifecycle

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
}
