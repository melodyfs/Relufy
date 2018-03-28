//
//  TabBarVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        
        let matchesNavController = createNavigationController(navTitle: nil, tabBarTitle: "Matches", unselectedImageName: nil, selectedImageName: nil, rootViewController: MatchesVC())

        let messagesNavController = createNavigationController(navTitle: "Messages", tabBarTitle: "Messages", unselectedImageName: nil, selectedImageName: nil, rootViewController: MessagesVC())
            
//            SavedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let profileNavController = createNavigationController(navTitle: "My Profile", tabBarTitle: "Profile", unselectedImageName: nil, selectedImageName: nil, rootViewController: ProfileVC())
        
        // Add each controller in the view controllers array
        viewControllers = [matchesNavController, messagesNavController, profileNavController]
        
        
        // modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    // Create and return a custom tab bar navigation controller
    private func createNavigationController(navTitle: String?, tabBarTitle: String?, unselectedImageName: UIImage?, selectedImageName: UIImage?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        viewController.navigationItem.title = navTitle
        
        // setup NavigationController with a rootViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        
        // setup TabBarItemImage
        if let unselectedImageName = unselectedImageName, let selectedImageName = selectedImageName {
            navigationController.tabBarItem.image = unselectedImageName
            navigationController.tabBarItem.selectedImage = selectedImageName
            
        }
        
        tabBar.isTranslucent = false
        
        return navigationController
    }
    
    
}
