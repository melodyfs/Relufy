//
//  AppKeys.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import KeychainSwift

class AppKeys {
    struct DomainKeys {
        static let loggedIn = "loggedIn"
        static let isMentor = "isMentor"
    }
    
    static let instance = AppKeys()
    private let userDefaults = UserDefaults()
    
    var isLoggedIn: Bool {
        return userDefaults.bool(forKey: DomainKeys.loggedIn)
    }
    
    var isMentor: Bool {
        return userDefaults.bool(forKey: DomainKeys.isMentor)
    }

    private init() {}
    
    func set(isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: DomainKeys.loggedIn)
    }
    
    func setMentorOrMentee(isMentor: Bool) {
        userDefaults.set(isMentor, forKey: DomainKeys.isMentor)
        if isMentor == true {
            token = keychain.get("token-mentor")!
            userID = keychain.get("id-mentor")!
        } else {
            token = keychain.get("token")!
            userID = keychain.get("id")!
        }
    }
    
}
