//
//  PracticeViewController.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/17/25.
//

import UIKit

class PracticeViewController: UIViewController {
    
    private let practiceView = PracticeView()
    
    // Lesson data passed from previous screen
    var selectedLesson: Lesson?
    
    // Practice session data
    private var currentStepIndex = 0
    private var totalSteps = 5 // This should come from your lesson data
    private var isTipsExpanded = true
    
    // MARK: - Lifecycle
    override func loadView() {
        view = practiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        updateContent()
        updateProgress()
    }
    
    // MARK: - Setup
    private func setupActions() {
        practiceView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        practiceView.previousButton.addTarget(self, action: #selector(previousTapped), for: .touchUpInside)
        practiceView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        practiceView.tipsHeaderButton.addTarget(self, action: #selector(toggleTips), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func previousTapped() {
        guard currentStepIndex > 0 else { return }
        currentStepIndex -= 1
        updateContent()
        updateProgress()
    }
    
    @objc private func nextTapped() {
        guard currentStepIndex < totalSteps - 1 else {
            // Reached the end - could show completion screen or return to library
            showCompletionAlert()
            return
        }
        currentStepIndex += 1
        updateContent()
        updateProgress()
    }
    
    @objc private func toggleTips() {
        isTipsExpanded.toggle()
        practiceView.toggleTips(isExpanded: isTipsExpanded)
    }
    
    // MARK: - Update Methods
    private func updateContent() {
        // TODO: Update image and tips from actual lesson data
        
        // Update button states
        practiceView.previousButton.isEnabled = currentStepIndex > 0
        practiceView.previousButton.alpha = currentStepIndex > 0 ? 1.0 : 0.5
        
        practiceView.nextButton.isEnabled = currentStepIndex < totalSteps - 1
        practiceView.nextButton.alpha = currentStepIndex < totalSteps - 1 ? 1.0 : 0.5
    }
    
    private func updateProgress() {
        let progress = Float(currentStepIndex + 1) / Float(totalSteps)
        practiceView.updateProgress(progress)
    }
    
    private func showCompletionAlert() {
        let alert = UIAlertController(
            title: "Practice Complete!",
            message: "Great job! You've completed all steps in this lesson.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Continue Practicing", style: .default) { [weak self] _ in
            self?.currentStepIndex = 0
            self?.updateContent()
            self?.updateProgress()
        })
        
        alert.addAction(UIAlertAction(title: "Return to Library", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
}
