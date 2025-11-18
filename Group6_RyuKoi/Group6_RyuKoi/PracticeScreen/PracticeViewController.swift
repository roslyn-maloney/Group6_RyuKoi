//
//  PracticeViewController.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/17/25.
//

import UIKit

class PracticeViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedLesson: Lesson?
    
    private let practiceView = PracticeView()
    private var lessons: [PracticeLesson] = []
    private var currentIndex: Int = 0
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = practiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lesson = selectedLesson {
            print("Showing practices for: \(lesson.title)")
        }
        setupData()
        setupActions()
        updateLesson()
    }
    
    // MARK: - Setup
    
    private func setupData() {
        // Sample data - replace with actual lesson data
        lessons = [
            PracticeLesson(
                imageName: "martial_arts_pose_1",
                tips: "Keep your stance wide and balanced. Distribute weight evenly on both feet. Keep your hands up to protect your face.",
                currentStep: 1,
                totalSteps: 5
            ),
            PracticeLesson(
                imageName: "martial_arts_pose_2",
                tips: "Rotate your hips for maximum power. Keep your core engaged and maintain good posture throughout the movement.",
                currentStep: 2,
                totalSteps: 5
            ),
            PracticeLesson(
                imageName: "martial_arts_pose_3",
                tips: "Return to your starting position smoothly. Always maintain your guard and stay alert.",
                currentStep: 3,
                totalSteps: 5
            )
        ]
    }
    
    private func setupActions() {
        practiceView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        practiceView.previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        practiceView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func previousButtonTapped() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        updateLesson()
    }
    
    @objc private func nextButtonTapped() {
        guard currentIndex < lessons.count - 1 else { return }
        currentIndex += 1
        updateLesson()
    }
    
    // MARK: - Helper Methods
    
    private func updateLesson() {
        guard !lessons.isEmpty else { return }
        practiceView.configure(with: lessons[currentIndex])
        
        // Enable/disable navigation buttons based on position
        practiceView.previousButton.isEnabled = currentIndex > 0
        practiceView.nextButton.isEnabled = currentIndex < lessons.count - 1
        
        practiceView.previousButton.alpha = currentIndex > 0 ? 1.0 : 0.3
        practiceView.nextButton.alpha = currentIndex < lessons.count - 1 ? 1.0 : 0.3
    }
}
