//
//  PracticeView.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/17/25.
//

import UIKit

class PracticeView: UIView {
    
    // MARK: - UI Components
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .darkBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = .darkBrown
        progress.trackTintColor = .lightBeige
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .mediumBeige
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .darkBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .darkBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tipsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBeige
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tipsHeaderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "Tips:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .darkBrown
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tipsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .darkBrown
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // Constraint for collapsing
    var tipsTextViewHeightConstraint: NSLayoutConstraint!
    
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
        backgroundColor = .backgroundBeige
        
        addSubview(backButton)
        addSubview(progressBar)
        addSubview(contentContainer)
        contentContainer.addSubview(imageView)
        contentContainer.addSubview(previousButton)
        contentContainer.addSubview(nextButton)
        addSubview(tipsContainer)
        tipsContainer.addSubview(tipsHeaderButton)
        tipsHeaderButton.addSubview(tipsLabel)
        tipsHeaderButton.addSubview(chevronImageView)
        tipsContainer.addSubview(tipsTextView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tipsTextViewHeightConstraint = tipsTextView.heightAnchor.constraint(equalToConstant: 150)
        
        NSLayoutConstraint.activate([
            // Back button
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Progress bar
            progressBar.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            
            // Content container
            contentContainer.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            // Image view
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: previousButton.topAnchor, constant: -20),
            
            // Previous button
            previousButton.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 40),
            previousButton.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -20),
            previousButton.widthAnchor.constraint(equalToConstant: 44),
            previousButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Next button
            nextButton.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -40),
            nextButton.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 44),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Tips container
            tipsContainer.topAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: 20),
            tipsContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tipsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tipsContainer.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Tips header button
            tipsHeaderButton.topAnchor.constraint(equalTo: tipsContainer.topAnchor),
            tipsHeaderButton.leadingAnchor.constraint(equalTo: tipsContainer.leadingAnchor),
            tipsHeaderButton.trailingAnchor.constraint(equalTo: tipsContainer.trailingAnchor),
            tipsHeaderButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Tips label
            tipsLabel.leadingAnchor.constraint(equalTo: tipsHeaderButton.leadingAnchor, constant: 16),
            tipsLabel.centerYAnchor.constraint(equalTo: tipsHeaderButton.centerYAnchor),
            
            // Chevron
            chevronImageView.trailingAnchor.constraint(equalTo: tipsHeaderButton.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: tipsHeaderButton.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Tips text view
            tipsTextView.topAnchor.constraint(equalTo: tipsHeaderButton.bottomAnchor),
            tipsTextView.leadingAnchor.constraint(equalTo: tipsContainer.leadingAnchor),
            tipsTextView.trailingAnchor.constraint(equalTo: tipsContainer.trailingAnchor),
            tipsTextView.bottomAnchor.constraint(equalTo: tipsContainer.bottomAnchor, constant: -8),
            tipsTextViewHeightConstraint
        ])
    }
    
    // MARK: - Public Methods
    func updateProgress(_ progress: Float) {
        progressBar.setProgress(progress, animated: true)
    }
    
    func toggleTips(isExpanded: Bool) {
        UIView.animate(withDuration: 0.3) {
            if isExpanded {
                self.chevronImageView.transform = CGAffineTransform(rotationAngle: 0)
                self.tipsTextViewHeightConstraint.constant = 150
            } else {
                self.chevronImageView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
                self.tipsTextViewHeightConstraint.constant = 0
            }
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Color Extensions
extension UIColor {
    static let backgroundBeige = UIColor(red: 0.96, green: 0.92, blue: 0.84, alpha: 1.0)
    static let lightBeige = UIColor(red: 0.93, green: 0.89, blue: 0.80, alpha: 1.0)
    static let mediumBeige = UIColor(red: 0.87, green: 0.80, blue: 0.65, alpha: 1.0)
    static let darkBrown = UIColor(red: 0.40, green: 0.20, blue: 0.10, alpha: 1.0)
}
