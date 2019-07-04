//
//  JSONModel.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 25/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import Foundation

struct JSONFriendModel: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var items: [Item]
        
        struct Item: Decodable {
            let firstName: String
            let lastName: String
            let photo200Orig: String
        }
    }
}




