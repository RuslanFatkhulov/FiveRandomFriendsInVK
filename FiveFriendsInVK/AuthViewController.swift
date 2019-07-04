//
//  ViewController.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 24/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authManager = AuthManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func authButtonTapped(_ sender: UIButton) {
        authManager.wakeUpSession()
    }
}

