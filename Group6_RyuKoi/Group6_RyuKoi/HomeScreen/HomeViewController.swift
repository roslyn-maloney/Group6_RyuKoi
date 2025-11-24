//
//  HomeViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add ability to "heart" a lesson to add to favorites // changed some stuff with bottom nav bar??? dunno how it works.

import UIKit

class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    var receivedCategory = "" // To be changed with the category...
    
    // MARK: - Lesson Data
    private var lessons: [Lesson] = []
    
    // Map category name to MartialArt enum
    private var martialArtType: MartialArt {
        switch receivedCategory.lowercased() {
        case "taekwondo":
            return .taekwondo
        case "karate":
            return .karate
        case "boxing":
            return .boxing
        case "jujutsu", "jujustu":
            return .bjj
        case "mixed martial arts", "mma":
            return .mma
        case "wrestling":
            return .wrestling
        case "judo":
            return .judo
        case "kickboxing":
            return .kickboxing
        case "muay thai":
            return .muayThai
        default:
            return .taekwondo // Default fallback
        }
    }
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide default Swift navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true
        
        // Generate lessons for this martial art
        generateLessons()
        
        homeScreen.updateCategory(receivedCategory)
        
        // Remove separator line between cells
        homeScreen.tableViewLessons.separatorStyle = .none
        
        // Patching the table view delegate and datasource to controller
        homeScreen.tableViewLessons.delegate = self
        homeScreen.tableViewLessons.dataSource = self
        
        // Setup navbar button targets
        homeScreen.setAccountTarget(self, action: #selector(openProfile))
        homeScreen.setLogoTarget(self, action: #selector(openHome))
        homeScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func openHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods
    private func generateLessons() {
        // Generate 6 lessons with varying progress states
        lessons = [
            Lesson(title: "Lesson 1", progressState: .notStarted, martialArt: martialArtType),
            Lesson(title: "Lesson 2", progressState: .notStarted, martialArt: martialArtType),
            Lesson(title: "Lesson 3", progressState: .notStarted, martialArt: martialArtType),
            Lesson(title: "Lesson 4", progressState: .notStarted, martialArt: martialArtType),
            Lesson(title: "Lesson 5", progressState: .notStarted, martialArt: martialArtType),
            Lesson(title: "Lesson 6", progressState: .notStarted, martialArt: martialArtType)
        ]
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Each row displays 2 lessons, so divide by 2 and round up
        return (lessons.count + 1) / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessons", for: indexPath) as! HomeTableViewCell
        
        let leftIndex = indexPath.row * 2
        let rightIndex = leftIndex + 1
        
        // Configure left lesson
        if leftIndex < lessons.count {
            let leftLesson = lessons[leftIndex]
            cell.leftLabel.text = leftLesson.title
            
            // Setup left lesson tap
            cell.onLeftTap = { [weak self] in
                self?.navigateToLessonDetail(lesson: leftLesson, lessonIndex: leftIndex)
            }
        }
        
        // Configure right lesson
        if rightIndex < lessons.count {
            let rightLesson = lessons[rightIndex]
            cell.rightLessonView.isHidden = false
            cell.rightLabel.text = rightLesson.title
            
            // Setup right lesson tap
            cell.onRightTap = { [weak self] in
                self?.navigateToLessonDetail(lesson: rightLesson, lessonIndex: rightIndex)
            }
        } else {
            cell.rightLessonView.isHidden = true
            cell.onRightTap = nil
        }
        
        return cell
    }
    
    // MARK: - Navigation
    private func navigateToLessonDetail(lesson: Lesson, lessonIndex: Int) {
        let lessonDetailVC = LessonDetailViewController()
        lessonDetailVC.lessonNumber = lessonIndex + 1 // Lessons are 1-indexed
        lessonDetailVC.lesson = lesson
        navigationController?.pushViewController(lessonDetailVC, animated: true)
    }
}
