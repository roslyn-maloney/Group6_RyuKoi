//
//  HomeViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add ability to "heart" a lesson to add to favorites // changed some stuff with bottom nav bar??? dunno how it works.

import UIKit

class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    var receivedCategory = "" // To be changed with the category...
    let lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5", "Lesson 6"]
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // remove separator line between cells
        homeScreen.tableViewLessons.separatorStyle = .none
        
        
        //MARK: patching the table view delegate and datasource to controller...
        homeScreen.tableViewLessons.delegate = self
        homeScreen.tableViewLessons.dataSource = self
        
        homeScreen.setAccountTarget(self, action: #selector(openProfile))
        homeScreen.setLogoTarget(self, action: #selector(openHome))
        homeScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func openHome() {
        let homeController = HomeViewController()
        navigationController?.pushViewController(homeController, animated: true)
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Two lessons per cell
        return Int(ceil(Double(lessons.count) / 2.0))
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessons",
                                                 for: indexPath) as! HomeTableViewCell
        
        let leftIndex = indexPath.row * 2
        let rightIndex = leftIndex + 1
        
        // Left lesson
        cell.leftLabel.text = lessons[leftIndex]
        
        // Right lesson (optional)
        if rightIndex < lessons.count {
            cell.rightLessonView.isHidden = false
            cell.rightLabel.text = lessons[rightIndex]
        } else {
            cell.rightLessonView.isHidden = true
        }
        
        return cell
    }
}
