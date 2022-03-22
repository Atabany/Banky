//
//  ViewController.swift
//  Password
//
//  Created by Mohamed Elatabany on 21/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextfield(placeHolderText: "New password")
    let stackView = UIStackView()
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextfield(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)

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
        newPasswordTextField.delegate = self
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        

    }
    
    private func layout() {
        
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)

        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
    }
}


// Udate StatusView
extension ViewController {
    //            PasswordCriteria.isValidLengthAndNoWhiteSpaces(text: passwordTextField.textField.text!) ?
    //            (statusView.lengthCriteriaView.isCriteriaMet = true) :
    //            (statusView.lengthCriteriaView.reset())

    
    
//    func displayView
}


//MARK: -  PasswordTextfieldDelegate

extension ViewController: PasswordTextfieldDelegate {

    func editingChanged(_ sender: PasswordTextfield) {
        if sender == newPasswordTextField {
            statusView.updateDiplay(sender.textField.text!)
        }
    }
    
    
}


