//
//  PreferenceViewController.swift
//  RyūKoi
//
//  Created by Joshua Paulino Ozuna on 11/15/25.
//
//ADD- imagery for each martial art and ig for the levels as well. expand the container size and make it more boxy than pill
// MARK: - PreferenceViewController.swift
import UIKit

class PreferenceViewController: UIViewController {
    
    // MARK: - Properties
    private var preferenceView: PreferenceView!
    private var selectedLevel: String?
    private var selectedCategories: Set<String> = []
    private let maxCategories = 2
    
    private let levels = ["Beginner", "Intermediate", "Advance"]
    private let categories = [
        ["Taekwondo", "Karate", "Boxing"],
        ["Mixed Martial Arts", "Wrestling", "Judo"],
        ["Brazilian Jiu-Jitsu", "Kickboxing", "Muay Thai"]
    ]
    
    // MARK: - Lifecycle
    override func loadView() {
        preferenceView = PreferenceView()
        view = preferenceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupButtons() {
        setupLevelButtons()
        setupCategoryButtons()
    }
    
    private func setupActions() {
        preferenceView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    private func setupLevelButtons() {
        for (index, level) in levels.enumerated() {
            let button = preferenceView.createPillButton(title: level, tag: index)
            button.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
            preferenceView.levelStackView.addArrangedSubview(button)
        }
    }
    
    private func setupCategoryButtons() {
        for row in categories {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.distribution = .fillProportionally
            
            for category in row {
                let flatIndex = categories.flatMap { $0 }.firstIndex(of: category)!
                let button = preferenceView.createPillButton(title: category, tag: 100 + flatIndex)
                button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
                rowStack.addArrangedSubview(button)
            }
            
            preferenceView.categoryStackView.addArrangedSubview(rowStack)
        }
    }
    
    // MARK: - Actions
    @objc private func levelButtonTapped(_ sender: UIButton) {
        deselectAllLevelButtons()
        selectButton(sender)
        selectedLevel = sender.titleLabel?.text
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        if selectedCategories.contains(title) {
            deselectCategory(title, button: sender)
        } else if selectedCategories.count < maxCategories {
            selectCategory(title, button: sender)
        } else {
            showMaxCategoriesAlert()
        }
    }
    
    @objc private func submitTapped() {
        // Validate that user has made selections
        guard let level = selectedLevel, !selectedCategories.isEmpty else {
            showValidationError()
            return
        }
        
        // Save preferences
        savePreferences(level: level, categories: Array(selectedCategories))
        
        // Navigate to Lesson Library
        navigateToLessonLibrary()
    }
    
    // MARK: - Helper Methods
    private func deselectAllLevelButtons() {
        for case let button as UIButton in preferenceView.levelStackView.arrangedSubviews {
            deselectButton(button)
        }
    }
    
    private func selectButton(_ button: UIButton) {
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
    }
    
    private func deselectButton(_ button: UIButton) {
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.setTitleColor(.darkGray, for: .normal)
    }
    
    private func selectCategory(_ category: String, button: UIButton) {
        selectedCategories.insert(category)
        selectButton(button)
    }
    
    private func deselectCategory(_ category: String, button: UIButton) {
        selectedCategories.remove(category)
        deselectButton(button)
    }
    
    private func showMaxCategoriesAlert() {
        let alert = UIAlertController(
            title: "Maximum Reached",
            message: "You can only select up to \(maxCategories) categories",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showValidationError() {
        let alert = UIAlertController(
            title: "Incomplete Selection",
            message: "Please select a skill level and at least one category",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func savePreferences(level: String, categories: [String]) {
        // Save to UserDefaults
        UserDefaults.standard.set(level, forKey: "skillLevel")
        UserDefaults.standard.set(categories, forKey: "selectedMartialArts")
        
        print("Preferences Saved - Level: \(level), Categories: \(categories)")
    }
    
    private func navigateToLessonLibrary() {
        let lessonLibraryVC = LessonViewController()
        navigationController?.pushViewController(lessonLibraryVC, animated: true)
    }
}
