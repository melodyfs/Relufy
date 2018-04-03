//
//  MatchesViewModel.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

class MatchesViewModel {
    
    let networking = ServerNetworking.shared
    var userInfo: [User] = []
    var userItems: [UserItemViewModel] = []
    
    init() {
        networking.fetch(route: .getMentee, data: nil) { info in
            let userInfoList = try? JSONDecoder().decode([User].self, from: info)
            self.userInfo = userInfoList!
            self.userItems = self.getUsers(users: self.userInfo)
//            print(self.userItems)
        }
    }
    
    func fetchUsers(callback: @escaping ([UserItemViewModel]) -> Void) {
        ServerNetworking.shared.fetch(route: .getMentee, data: nil) { info in
            let userInfoList = try? JSONDecoder().decode([User].self, from: info)
            self.userInfo = userInfoList!
            
            self.userItems = self.getUsers(users: self.userInfo)
            callback(self.userItems)
//            print(self.userItems)
        }
    }
    
    func getUsers(users: [User]) -> [UserItemViewModel] {
        return users.map(convertToUserItem)
    }
    
    func convertToUserItem(user: User) -> UserItemViewModel {
        return UserItemViewModel(
            name: "\(user.name ?? "None")",
            email: "\(user.email ?? "None")",
            role: "\(user.role?.capitalized ?? "None")",
            years: user.years_experience ?? 0,
            company: "\(user.company ?? "None")",
            gender: "\(user.gender ?? "None")",
            race: "\(user.race ?? "None")",
            image: "\(user.image_file ?? "None")"
        )
        
    }
    
}

struct UserItemViewModel {
    let name: String
    let email: String
    var role: String
    var years: Int
    var company: String
    var gender: String
    var race: String
    var image: String
    
}
