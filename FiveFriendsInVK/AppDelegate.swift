//
//  AppDelegate.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 24/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authManager: AuthManager!

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        self.authManager = AuthManager.shared
        authManager.delegate = self
        
        VKSdk.wakeUpSession(["friends"]) { (state, error) in
            if state == VKAuthorizationState.authorized {
                let friendsVC = UIStoryboard(name: "FiveFriends", bundle: nil).instantiateInitialViewController() as! FiveFriendsViewController
                self.window?.rootViewController = friendsVC
                self.window?.makeKeyAndVisible()
            } else {
                let friendsVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() as! AuthViewController
                self.window?.rootViewController = friendsVC
                self.window?.makeKeyAndVisible()
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
}

//MARK: - AuthManagerDelegate
extension AppDelegate: AuthManagerDelegate {
    
    func authManagerShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authManagerSignIn() {
        print(#function)
        let friendsVC = UIStoryboard(name: "FiveFriends", bundle: nil).instantiateInitialViewController() as! FiveFriendsViewController
        window?.rootViewController = friendsVC
    }
}

