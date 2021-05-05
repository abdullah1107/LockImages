//
//  AppDelegate.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import Firebase

let db = Firestore.firestore()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //if having username then
        //if let _ = Defaults.username {
        if let _ = defaults.string(forKey: "token") {
            
            print("App Delegate token check:", defaults.string(forKey: "token"))
            
            let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
            let mainNavController = storyboard.instantiateViewController(withIdentifier: "mynav")
            self.window?.rootViewController = mainNavController
            window?.makeKeyAndVisible()
        }
            //             if not having username in userDefault then goTo -> LoginViewController
        else {
            
            //let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
            //let loginNavController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")
            
            //                    self.window?.rootViewController = UIViewController.navigationHomeButton(mainNavController)
            //window?.makeKeyAndVisible()
        }
        
        
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
    
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        //window.makeKeyAndVisible()
        
        // add animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
        
    }
}
