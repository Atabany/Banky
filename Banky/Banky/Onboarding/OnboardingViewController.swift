//
//  OnboardingViewController.swift
//  Banky
//
//  Created by Mohamed Elatabany on 14/03/2022.
//



import UIKit
class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label     = UILabel()
    
    
    private var titleText: String
    
    
    private var heroImageName: String
    
    
    
    
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
    
    
}


extension OnboardingViewController {
    private func style() {
        view.backgroundColor = .systemBackground

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis                                      = .vertical
        stackView.spacing                                   = 20
        
        // Image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode                               = .scaleAspectFit
        imageView.image                                     = UIImage(named: heroImageName)!

        
        // label
        label.translatesAutoresizingMaskIntoConstraints     = false
        label.textAlignment                                 = .center
        label.adjustsFontSizeToFitWidth                     = true
        label.numberOfLines                                 = 0
        label.font                                          = UIFont.preferredFont(forTextStyle: .title3)
        label.text                                          = titleText
        
        
    }
    
    private func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1)
        ])
    }
}


