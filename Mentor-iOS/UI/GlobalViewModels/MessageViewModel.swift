//
//  ConversationViewModel.swift
//  Mentor-iOS
//
//  Created by Melody on 3/31/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MessageViewModel {

    let networking = ServerNetworking.shared
    var userInfo: [User] = []
    var messageItems: [MessageItemViewModel] = []
//    var userItems: [UserItemViewModel] = []
    var matchIDs = [Int]()
    var confirmed = [String: String]()
    var fetchedID = [Int]()

    init() {
        networking.getInfo(route: .getMatchesAll, params: [:]) { (info) in
            if let ids = try? JSONDecoder().decode([Int].self, from: info) {
                self.matchIDs = ids
            }
        }
    }
    
    func fetchMatches(callback: @escaping ([MessageItemViewModel]) -> Void) {
        networking.getInfo(route: .getMatchesAll, params: confirmed) { (info) in
            if let ids = try? JSONDecoder().decode([Int].self, from: info) {
            self.matchIDs = ids
            
            for i in self.matchIDs {
                if self.fetchedID.contains(i) {
                   print("existed")
                } else {
                    self.fetchedID.append(i)
                    ServerNetworking.shared.getInfo(route: .getMatchesImages, params: ["id": "\(i)"]) { info in
                        let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                        self.userInfo += userInfoList!
                        self.messageItems = self.getUsers(users: self.userInfo)
                        callback(self.messageItems)
                        print(self.messageItems)
                    }
                }
               
               
            }
        }
        }
    }
   
    func getUsers(users: [User]) -> [MessageItemViewModel] {
        return users.map(convertToMessageItem)
    }

    func convertToMessageItem(user: User) -> MessageItemViewModel {
        return MessageItemViewModel(
            name: "\(user.name ?? "None")",
            email: "\(user.email ?? "None")",
            role: "\(user.role?.capitalized ?? "None")",
            years: user.years_experience ?? 0,
            company: "\(user.company ?? "None")",
            image: "\(user.image_file ?? "None")",
            goal: "\(user.goal ?? "None")"
        )

    }

}

struct MessageItemViewModel {
    let name: String
    var email: String
    var role: String
    var years: Int
    var company: String
    var image: String
    var goal: String

}

