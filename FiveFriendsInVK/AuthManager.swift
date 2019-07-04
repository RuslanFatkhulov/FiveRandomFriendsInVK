//
//  AuthManager.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 24/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthManagerDelegate: class {
    func authManagerShouldShow(_ viewController: UIViewController)
    func authManagerSignIn()
}

class AuthManager: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    static let shared = AuthManager()
    
    private let appID = "7032308"
    private let vkSdk: VKSdk
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    weak var delegate: AuthManagerDelegate?
    
    
    func wakeUpSession() {
        let scope = ["friends"]
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                delegate?.authManagerSignIn()
            } else if state == VKAuthorizationState.initialized {
                VKSdk.authorize(scope)
            } else {
                print("error: \(String(describing: error))")
            }
        }
    }
    
    override private init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    //MARK: - VKSdkDelegate, VKSdkUIDelegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authManagerSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authManagerShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    }
}
