//
//  CollectionViewCell.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 25/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.cornerRadius = image.frame.size.height / 2
            image.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    
    func configureCell(cell: CollectionViewCell, indexPath: IndexPath, friends: [JSONFriendModel.Response.Item]) {
        
        let friend = friends[indexPath.row]
        cell.fullNameLabel.text = friend.firstName + " " + friend.lastName
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: friend.photo200Orig), let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.image.image = UIImage(data: imageData)
            }
        }
    }
}
