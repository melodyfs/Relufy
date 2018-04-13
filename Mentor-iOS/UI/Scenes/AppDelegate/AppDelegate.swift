//
//  AppDelegate.swift
//  Mentor-iOS
//
//  Created by Melody on 3/24/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import PusherSwift
import UserNotifications
import PushNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let pusher = Pusher(key: key)
    let pushNotifications = PushNotifications.shared

    var window: UIWindow?
    let viewModel = AppDelegateViewModel.instance
    
    // switch view controller when recieving notification
    func handleRootChange(viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func adjustKeyboard() {
        IQKeyboardManager.sharedManager().enabledToolbarClasses.append(LoginVC.self)
        IQKeyboardManager.sharedManager().enabledToolbarClasses.append(EditVC.self)
        IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses.append(EditVC.self)
        IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses.append(LoginVC.self)
        IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses.append(ConversationVC.self)
        IQKeyboardManager.sharedManager().disabledToolbarClasses.append(ConversationVC.self)
    }
    
    func style() {
        UINavigationBar.appearance().tintColor = UIColor.violetBlue
//        UINavigationBar.appearance().backgroundColor = UIColor.violetBlue
        UITabBar.appearance().tintColor = UIColor.violetBlue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.violetBlue]
    }
    
    func configNotifications() {
        self.pushNotifications.start(instanceId: instanceID)
        self.pushNotifications.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        viewModel.rootCallback = handleRootChange
        window?.rootViewController = viewModel.rootViewController
       
        window?.makeGradient(
            firstColor: UIColor.violetPurple,
            secondColor: UIColor.violetBlue
        )
        adjustKeyboard()
        window?.makeKeyAndVisible()
        style()
        
        configNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken) {
            try? self.pushNotifications.subscribe(interest: "new")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        completionHandler(.newData)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // PusherDelegate functions
    func subscribedToInterest(name: String) {
        print("Subscribed to interest: \(name)")
    }
    
    func registeredForPushNotifications(clientId: String) {
        print("Registered with Pusher for push notifications with clientId: \(clientId)")
        
    }


}

