//
//  LessonDetailView.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/24/25.
//


import UIKit

class LessonDetailView: UIView {
    
    // MARK: - UI Components
    let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1.0)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 235/255, blue: 210/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lessonTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lessonDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description of lesson"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = UIColor(red: 60/255, green: 20/255, blue: 20/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = UIColor(red: 250/255, green: 245/255, blue: 230/255, alpha: 1.0)
        
        addSubview(progressBar)
        addSubview(contentCard)
        contentCard.addSubview(lessonTitleLabel)
        contentCard.addSubview(lessonDescriptionLabel)
        contentCard.addSubview(startButton)
    }
    
    func setupConstraints(below topNavigation: UIView) {
        NSLayoutConstraint.activate([
            // Progress bar
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressBar.topAnchor.constraint(equalTo: topNavigation.bottomAnchor, constant: 20),
            progressBar.widthAnchor.constraint(equalToConstant: 60),
            progressBar.heightAnchor.constraint(equalToConstant: 4),
            
            // Content card
            contentCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentCard.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            contentCard.heightAnchor.constraint(equalToConstant: 360),
            
            // Lesson title
            lessonTitleLabel.centerXAnchor.constraint(equalTo: contentCard.centerXAnchor),
            lessonTitleLabel.topAnchor.constraint(equalTo: contentCard.topAnchor, constant: 80),
            
            // Lesson description
            lessonDescriptionLabel.centerXAnchor.constraint(equalTo: contentCard.centerXAnchor),
            lessonDescriptionLabel.topAnchor.constraint(equalTo: lessonTitleLabel.bottomAnchor, constant: 8),
            
            // Start button
            startButton.centerXAnchor.constraint(equalTo: contentCard.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: contentCard.bottomAnchor, constant: -40),
            startButton.widthAnchor.constraint(equalToConstant: 120),
            startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(lessonNumber: Int, martialArtType: String) {
        lessonTitleLabel.text = "LESSON \(lessonNumber)"
    }
}
