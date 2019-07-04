//
//  JSONUserModel.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 25/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import Foundation

struct JSONUserModel: Decodable {
    
    let response: Response
    
    struct Response: Decodable {
        let firstName: String
        let lastName: String
    }
}

