//
//  NetworkManager.swift
//  FiveFriendsInVK
//
//  Created by Ruslan Fatkhulov on 24/06/2019.
//  Copyright © 2019 Ruslan Fatkhulov. All rights reserved.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let authManager = AuthManager.shared
    private init() {}
    
    
    private func prepareURL(method: String, parameters: [String: String]) -> URL {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }

        return components.url!
    }
    
    func getFriendsData(completion: @escaping (_ friends: [JSONFriendModel.Response.Item]) -> ()) {
        
        guard let token = authManager.token else { return }
        let parameters = ["order" : "random",
                      "count" : "5",
                      "fields" : "photo_200_orig",
                      "access_token" : "\(token)",
                      "v" : "5.95"]
        let method = "/method/friends.get"
        
        let url = prepareURL(method: method, parameters: parameters)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(JSONFriendModel.self, from: data)
                completion(result.response.items)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    func getUserData(completion: @escaping (_ user: JSONUserModel) -> ()) {
        
        guard let token = authManager.token else { return }
        let parameters = ["access_token" : "\(token)",
                          "v" : "5.95"]
        let method = "/method/account.getProfileInfo"
        
        let url = prepareURL(method: method, parameters: parameters)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(JSONUserModel.self, from: data)
                completion(result)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
}
