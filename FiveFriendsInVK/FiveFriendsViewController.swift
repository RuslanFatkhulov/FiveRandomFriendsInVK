//
//  FiveFriendsViewController.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 24/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import UIKit

class FiveFriendsViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private var friends = [JSONFriendModel.Response.Item]()
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFriends()
        fetchUser()
    }
    
    private func fetchFriends() {
        networkManager.getFriendsData { (friends) in
            self.friends = friends
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func fetchUser() {
        networkManager.getUserData { (user) in
            DispatchQueue.main.async {
                self.firstNameLabel.text = "Здравствуйте, \(user.response.firstName) \(user.response.lastName)" 
            }
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FiveFriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.configureCell(cell: cell, indexPath: indexPath, friends: friends)
        
        return cell
    }
    
}
