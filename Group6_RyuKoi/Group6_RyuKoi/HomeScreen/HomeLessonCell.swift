//
//  HomeLessonCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class HomeLessonCell: UICollectionViewCell {
    
    static let identifier = "HomeLessonCell"
    
    let lessonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lessonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.tintColor = UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Closures for button actions
    var onHeartTapped: (() -> Void)?
    var onStarTapped: (() -> Void)?
    
    override var isSelected: Bool {
        didSet {
            // Highlight when selected
            lessonView.backgroundColor = isSelected
                ? UIColor(red: 220/255, green: 71/255, blue: 49/255, alpha: 0.53)
                : UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lessonView)
        lessonView.addSubview(lessonLabel)
        lessonView.addSubview(heartButton)
        lessonView.addSubview(starButton)
        
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lessonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lessonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lessonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lessonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Star button - top right
            starButton.topAnchor.constraint(equalTo: lessonView.topAnchor, constant: 8),
            starButton.trailingAnchor.constraint(equalTo: lessonView.trailingAnchor, constant: -8),
            starButton.widthAnchor.constraint(equalToConstant: 30),
            starButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Heart button - top left
            heartButton.topAnchor.constraint(equalTo: lessonView.topAnchor, constant: 8),
            heartButton.leadingAnchor.constraint(equalTo: lessonView.leadingAnchor, constant: 8),
            heartButton.widthAnchor.constraint(equalToConstant: 30),
            heartButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Lesson label - centered
            lessonLabel.centerXAnchor.constraint(equalTo: lessonView.centerXAnchor),
            lessonLabel.centerYAnchor.constraint(equalTo: lessonView.centerYAnchor),
            lessonLabel.leadingAnchor.constraint(greaterThanOrEqualTo: lessonView.leadingAnchor, constant: 8),
            lessonLabel.trailingAnchor.constraint(lessThanOrEqualTo: lessonView.trailingAnchor, constant: -8)
        ])
    }
    
    @objc private func heartButtonTapped() {
        heartButton.isSelected.toggle()
        onHeartTapped?()
    }
    
    @objc private func starButtonTapped() {
        starButton.isSelected.toggle()
        onStarTapped?()
    }
    
    func configure(with lesson: Lesson) {
        lessonLabel.text = lesson.title
        
        // Set button states based on lesson
        heartButton.isSelected = lesson.isLiked
        starButton.isSelected = lesson.isFavorited
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
