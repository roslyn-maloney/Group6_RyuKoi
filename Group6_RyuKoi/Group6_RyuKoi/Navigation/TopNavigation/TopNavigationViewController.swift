//
//  TopNavigationViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class TopNavigationViewController: UIViewController {
    let topNav = TopNavigationBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color for the main view
        view.backgroundColor = UIColor(red: 250/255, green: 245/255, blue: 230/255, alpha: 1.0)
        
        // Add topNav as a subview instead of replacing the entire view
        view.addSubview(topNav)
        topNav.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrain topNav to top of screen
        NSLayoutConstraint.activate([
            topNav.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topNav.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topNav.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topNav.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
