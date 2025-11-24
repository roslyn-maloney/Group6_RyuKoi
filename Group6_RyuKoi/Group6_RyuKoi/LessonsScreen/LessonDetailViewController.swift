import UIKit

class LessonDetailViewController: TopNavigationViewController {
    
    private let lessonDetailView = LessonDetailView()
    var lesson: Lesson?
    var lessonNumber: Int = 1
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide default navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        print("✅ LessonDetailViewController loaded")
        print("Lesson number: \(lessonNumber)")
        print("Lesson: \(lesson?.title ?? "nil")")
        
        setupViews()
        setupConstraints()
        configureView()
        setupActions()
    }
    
    private func setupViews() {
        // Add lessonDetailView behind everything else
        view.insertSubview(lessonDetailView, at: 0)
        view.addSubview(backButton)
        
        lessonDetailView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Lesson detail view fills entire screen
            lessonDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            lessonDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lessonDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lessonDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Back button below top nav
            backButton.topAnchor.constraint(equalTo: topNav.bottomAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Setup lesson detail view constraints
        lessonDetailView.setupConstraints(below: backButton)
    }
    
    private func configureView() {
        lessonDetailView.configure(lessonNumber: lessonNumber, martialArtType: lesson?.martialArt.description ?? "")
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        lessonDetailView.startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func startTapped() {
        let practiceVC = PracticeViewController()
        if let lesson = lesson {
            practiceVC.selectedLesson = lesson
        }
        navigationController?.pushViewController(practiceVC, animated: true)
    }
}
