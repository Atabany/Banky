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
        imageView.image                                     = UIImage(named: "delorean")!

        
        // label
        label.translatesAutoresizingMaskIntoConstraints     = false
        label.textAlignment                                 = .center
        label.adjustsFontSizeToFitWidth                     = true
        label.numberOfLines                                 = 0
        label.text                                          = "Banky is faster, easier to user, and has a brand new look and feel that will make you feel like you are back in 1989"
        label.font                                          = UIFont.preferredFont(forTextStyle: .title3)
        
        
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


