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
    var userInfoMentees = [User]()
    var messageItems: [MessageItemViewModel] = []
    var messageMenteeItems: [MessageItemViewModel] = []
//    var userItems: [UserItemViewModel] = []
    var menteeMatchIDs = [Int]()
    var matchIDs = [Int]()
    var confirmed = [String: String]()
    var fetchedID = [Int]()
    var fetchedMenteeID = [Int]()

    init() {
        networking.getInfo(route: .getMatchesAll, params: [:]) { (info) in
            if let ids = try? JSONDecoder().decode([Int].self, from: info) {
                self.matchIDs = ids
            }
        }
        
        networking.getMenteeMatches(params: [:]) { (info) in
            if let ids = try? JSONDecoder().decode([Int].self, from: info) {
                self.menteeMatchIDs = ids
            }
        }
    }
    
    func fetchMatches(callback: @escaping ([MessageItemViewModel]) -> Void) {
        networking.getInfo(route: .getMatchesAll, params: confirmed) { (info) in
            if let ids = try? JSONDecoder().decode([Int].self, from: info) {
            self.matchIDs = ids
            
            for i in self.matchIDs {
                if self.fetchedID.contains(i) {
//                   print("existed")
                } else {
                    self.fetchedID.append(i)
                    ServerNetworking.shared.getInfo(route: .getMatchesImages, params: ["id": "\(i)"]) { info in
                        let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                        self.userInfo += userInfoList!
                        self.messageItems = self.getUsers(users: self.userInfo)
                        callback(self.messageItems)
//                        print(self.messageItems)
                    }
                }
               
               
            }
        }
        }
    }
    
    func fetchMenteeMatches(callback: @escaping ([MessageItemViewModel]) -> Void) {
        networking.getMenteeMatches(params: confirmed) { (info) in
            if let ids = try? JSONDecoder().decode([Int].self, from: info) {
                self.menteeMatchIDs = ids
                
                for i in self.menteeMatchIDs {
                    if self.fetchedMenteeID.contains(i) {
//                        print("existed")
                    } else {
                        self.fetchedMenteeID.append(i)
                        ServerNetworking.shared.getMenteeMatchesImages(params: ["id": "\(i)"]) { info in
                            let userInfoList = try? JSONDecoder().decode([User].self, from: info)
                            self.userInfoMentees += userInfoList!
                            self.messageMenteeItems = self.getUsers(users: self.userInfoMentees)
                            callback(self.messageMenteeItems)
//                            print(self.messageItems)
                        }
                    }
                    
                    
                }
            }
        }
    }
   
    func getUsers(users: [User]) -> [MessageItemViewModel] {
        return users.map(convertToMessageItem)
    }

    // get rid of it
    func convertToMessageItem(user: User) -> MessageItemViewModel {
        return MessageItemViewModel(
            id: user.id ?? 0,
            name: "\(user.name ?? "None")",
            email: "\(user.email ?? "None")",
            role: "\(user.role?.capitalized ?? "None")",
            years: user.years_experience ?? 0,
            company: "\(user.company ?? "None")",
            image: "\(user.image_file ?? "None")",
            goal: "\(user.goal ?? "None")",
            race: "\(user.race ?? "None")",
            gender: "\(user.gender ?? "None")"
        )

    }

}

struct MessageItemViewModel {
    var id: Int
    var name: String
    var email: String
    var role: String
    var years: Int
    var company: String
    var image: String
    var goal: String
    var race: String
    var gender: String

}

