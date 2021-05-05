//
//  SceneDelegate.swift
//  RoadsAndHighways
//
//  Created by Fahim Rahman on 7/7/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        //if having username then
        //if let _ = Defaults.username {
        if let _ = defaults.string(forKey: "token") {
        
            print("Scene Delegate token check:", defaults.string(forKey: "token"))
            
            let storyboard = UIStoryboard(name: "Badhon", bundle: nil)
            let mainNavController = storyboard.instantiateViewController(identifier: "mynav")
            self.window?.rootViewController = mainNavController
            //window?.makeKeyAndVisible()
        }
            //if not having username in userDefault then goTo -> LoginViewController
        else{
            print("inside loging......")

            let storyboard = UIStoryboard(name: "Fahim", bundle: nil)
            let loginNavController = storyboard.instantiateViewController(identifier: "NavigationViewController")

            self.window?.rootViewController = loginNavController
           // window?.makeKeyAndVisible()
            //nagationController
        }
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
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}
