//
//  BottomNavigationViewController.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/17/25.
//

import UIKit

class BottomNavigationViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: setting up red tab bar...
        let tabHome = UINavigationController(rootViewController: HomeViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "house.filled")
        )
        tabHome.tabBarItem = tabHomeBarItem
        tabHome.title = "Home"
        
        //MARK: setting up green tab bar...
//        let tabFavorites = UINavigationController(rootViewController: GreenViewController())
//        let tabFavoriteBarItem = UITabBarItem(
//            title: "Favorties",
//            image: UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysOriginal),
//            selectedImage: UIImage(systemName: "bookmark.fill")
//        )
//        tabFavorites.tabBarItem = tabFavoriteBarItem
//        tabFavorites.title = "Favorites"
        
        //MARK: setting up blue tab bar...
        let tabEvents = UINavigationController(rootViewController: CommunitiesViewController())
        let tabEventsBarItem = UITabBarItem(
            title: "Events",
            image: UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "bell.fill")
        )
        tabEvents.tabBarItem = tabEventsBarItem
        tabEvents.title = "Events"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabEvents]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
