//
//  ViewController.swift
//  Password
//
//  Created by Mohamed Elatabany on 21/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextfield(placeHolderText: "New Pass")
    let stackView = UIStackView()
    let criteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}


extension ViewController {
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        criteriaView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func layout() {
        
//        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(criteriaView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
    }
}


