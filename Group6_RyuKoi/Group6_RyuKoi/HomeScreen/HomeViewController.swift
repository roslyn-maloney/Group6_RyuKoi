//
//  HomeViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add ability to "heart" a lesson to add to favorites
// need to change table view to grid view for lessons/favorites/communities

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
        
        // Patching the collection view delegate and datasource to controller
        homeScreen.collectionViewLessons.delegate = self
        homeScreen.collectionViewLessons.dataSource = self
        
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
            Lesson(title: "Lesson 1", progressState: .notStarted, progressPercentage: 0, martialArt: martialArtType, favorite: false),
            Lesson(title: "Lesson 2", progressState: .notStarted, progressPercentage: 0, martialArt: martialArtType, favorite: false),
            Lesson(title: "Lesson 3", progressState: .notStarted, progressPercentage: 0, martialArt: martialArtType, favorite: false),
            Lesson(title: "Lesson 4", progressState: .notStarted, progressPercentage: 0, martialArt: martialArtType, favorite: false),
            Lesson(title: "Lesson 5", progressState: .notStarted, progressPercentage: 0, martialArt: martialArtType, favorite: false),
            Lesson(title: "Lesson 6", progressState: .notStarted, progressPercentage: 0, martialArt: martialArtType, favorite: false)
        ]
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeLessonCell",
            for: indexPath
        ) as! HomeLessonCell

        cell.configure(with: lessons[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lesson = lessons[indexPath.item]
        navigateToLessonDetail(lesson: lesson, lessonIndex: indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 12
        let totalSpacing = spacing * 3
        let width = (collectionView.bounds.width - totalSpacing) / 2

        return CGSize(width: width, height: 150)
    }
    
    // MARK: - Navigation
    private func navigateToLessonDetail(lesson: Lesson, lessonIndex: Int) {
        let lessonDetailVC = LessonDetailViewController()
        lessonDetailVC.lessonNumber = lessonIndex + 1 // Lessons are 1-indexed
        lessonDetailVC.lesson = lesson
        navigationController?.pushViewController(lessonDetailVC, animated: true)
    }
}
