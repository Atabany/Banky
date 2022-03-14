//
//  ViewController.swift
//  Banky
//
//  Created by Mohamed Elatabany on 13/03/2022.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    
    var username: String? {
        return loginView.usernameTextfield.text
    }
    
    var password: String? {
        return loginView.passwordTextfield.text
    }

    
    var errorMessage: String = "" {
        didSet {
            configureView(withMessage: errorMessage)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
  
    
    

}


extension LoginViewController {
    private func style() {
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign in", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment                             = .center
        errorMessageLabel.textColor                                 = .systemRed
        errorMessageLabel.numberOfLines                             = 0
        errorMessageLabel.text                                      = "Failure error"
        errorMessageLabel.isHidden                                  = true

    }
    
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)

        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
        ])
        
        // SignIn Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
        ])
        
        
        // Message Error label
        NSLayoutConstraint.activate([
             errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
             errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
             errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])


    }
}

//MARK: - Actions

extension LoginViewController {
    
    @objc
    func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "username / password cannot be blank"
            return
        }
        
        
        if username == "Atabany" && password == "123456" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Icorrect username / password")
        }
    }
    
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = message.isEmpty
    }
}
