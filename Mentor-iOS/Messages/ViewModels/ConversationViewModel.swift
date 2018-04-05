//
//  ConversationViewModel.swift
//  Mentor-iOS
//
//  Created by Melody on 4/3/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

class ConversationViewModel {
    
    let networking = ServerNetworking.shared
    var messages = [Message]()
    var convItems: [ConversationItemViewModel] = []
    var channelName = [String: String]()
    
    init() {
        networking.getInfo(route: .getSingleChatHistory, params: channelName) { (msg) in
            let messageList = try? JSONDecoder().decode([Message].self, from: msg)
            self.messages = messageList!
        }
    }
    
    func fetchConversation(callback: @escaping ([ConversationItemViewModel]) -> Void) {
        networking.getInfo(route: .getSingleChatHistory, params: channelName) { (msg) in
            let messageList = try? JSONDecoder().decode([Message].self, from: msg)
            self.messages = messageList!
            self.convItems = self.getConv(msg: self.messages)
            callback(self.convItems)
            
        }
    }
    
    func getConv(msg: [Message]) -> [ConversationItemViewModel] {
        return msg.map(convertToConvItem)
    }

    func convertToConvItem(msg: Message) -> ConversationItemViewModel {
        return ConversationItemViewModel(
            sender: "\(msg.sender ?? "None")",
            content: "\(msg.content ?? "None")"
        )

    }
    
}

struct ConversationItemViewModel {
    var sender: String
    var content: String
}



