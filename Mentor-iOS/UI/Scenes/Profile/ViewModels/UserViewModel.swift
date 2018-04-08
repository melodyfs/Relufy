//
//  MatchesViewModel.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

class UserViewModel {
    
    let networking = ServerNetworking.shared
    var userInfo: [User] = []
    var userItems: [UserItemViewModel] = []
    let keys = AppKeys.instance
    
    init() {
        if keys.isMentor {
            networking.getInfo(route: .getMentorInfo, params: [:]) { info in
                let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                self.userInfo = userInfoList!
                self.userItems = self.getUsers(users: self.userInfo)
            }
        } else {
            networking.getInfo(route: .getMenteeInfo, params: [:]) { info in
                let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                self.userInfo = userInfoList!
                self.userItems = self.getUsers(users: self.userInfo)
            }
        }
    }
    
    func fetchUsers(callback: @escaping ([UserItemViewModel]) -> Void) {
        
        if keys.isMentor {
            ServerNetworking.shared.getInfo(route: .getMentorInfo, params: [:]) { info in
                let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                self.userInfo = userInfoList!
                
                self.userItems = self.getUsers(users: self.userInfo)
                callback(self.userItems)
            }
        } else {
            ServerNetworking.shared.getInfo(route: .getMenteeInfo, params: [:]) { info in
                let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                self.userInfo = userInfoList!
                
                self.userItems = self.getUsers(users: self.userInfo)
                callback(self.userItems)
            }
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
            image: "\(user.image_file ?? "None")",
            goal: "\(user.goal ?? "None")"
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
    var goal: String
}
