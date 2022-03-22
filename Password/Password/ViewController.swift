//
//  ViewController.swift
//  Password
//
//  Created by Mohamed Elatabany on 21/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    typealias CustomValidation = PasswordTextfield.CustomValidation
    
    let newPasswordTextField = PasswordTextfield(placeHolderText: "New password")
    let stackView = UIStackView()
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextfield(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    
    
}


extension ViewController {
    
    private func setup() {
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    
    private func setupNewPassword() {
        
        let newPasswordValidation: CustomValidation = { text in
            // empty text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }

            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            // Criteria Met
            self.statusView.updateDiplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            return (true, "")
        }
        
        newPasswordTextField.customValidatoin = newPasswordValidation
        newPasswordTextField.delegate = self
    }
    
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "enter confirm password")
            }
            
            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match")
            }
            
            return (true, "")
        }
        confirmPasswordTextField.customValidatoin = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    
    @objc
    func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    private func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
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

//MARK: -  PasswordTextfieldDelegate
extension ViewController: PasswordTextfieldDelegate {
    func editingChanged(_ sender: PasswordTextfield) {
        if sender === newPasswordTextField {
            statusView.shouldResetCriteria = true
            statusView.updateDiplay(sender.textField.text!)
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextfield) {
        if sender === newPasswordTextField {
            statusView.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        } else if sender === confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
    
}


//MARK: - Actions

extension ViewController {
    
    @objc
    func resetButtonTapped() {
        
    }
    
}

