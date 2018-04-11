//
//  AppDelegateViewModel.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

import UIKit

enum AuthStatus {
    case authorized
    case unauthorized
    case backToProfile
    case editProfile
}

typealias RootCallback = (_ viewController: UIViewController) -> Void

class AppDelegateViewModel {
    static let instance = AppDelegateViewModel()
    let keys = AppKeys.instance
    let rootViewController: UIViewController
    var authStatus: AuthStatus = .unauthorized
    var rootCallback: RootCallback?
    
    //remove observer
    deinit {
        NotificationCenter
            .default
            .removeObserver(self, name: Notification.Name("authorized"), object: nil)
    }
    
    init() {
        
        authStatus = keys.isLoggedIn ? .authorized : .unauthorized
        
        switch authStatus {
        case .authorized:
            rootViewController = TabBarController()
        case .unauthorized:
            rootViewController = OpenningVC()
        case .backToProfile:
           TabBarController().tabBarController?.selectedIndex = 2
            let vc = TabBarController().tabBarController?.selectedViewController
            rootViewController = vc!
//            rootViewController.tabBarController?.selectedViewController = ProfileVC()
        case .editProfile:
            rootViewController = EditVC()
        }
        
        //switch view controller - recieve notification
        NotificationCenter
            .default
            .addObserver(
                forName: Notification.Name("authorized"),
                object: nil,
                queue: nil,
                using: changeRootViewController
        )
        
    }
    
    //switch root view controller - after recieving the notification
    @objc func changeRootViewController(notification: Notification) {
        guard let authStatus = notification.object as? AuthStatus,
            let rootCallback = rootCallback
            else {return}
        
        var rootViewController: UIViewController
        
        switch authStatus {
        case .authorized:
            rootViewController = TabBarController()
            keys.set(isLoggedIn: true)
        case .unauthorized:
            rootViewController = OpenningVC()
            keys.set(isLoggedIn: false)
        case .backToProfile:
            keys.set(isLoggedIn: true)
            rootViewController = TabBarController()
            rootViewController.tabBarController?.selectedIndex = 2
//            rootViewController.tabBarController?
        case .editProfile:
            rootViewController = EditVC()
        }
        
        rootCallback(rootViewController)
    }
    
    func changeStatus(authStatus: AuthStatus) {
        self.authStatus = authStatus
        //switch view controller - post notification
        NotificationCenter.default.post(
            name: Notification.Name("authorized"),
            object: authStatus
        )
    }
}
