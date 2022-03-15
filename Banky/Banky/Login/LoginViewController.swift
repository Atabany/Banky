//
//  ViewController.swift
//  Banky
//
//  Created by Mohamed Elatabany on 13/03/2022.
//

import UIKit
import Combine

protocol LoginViewControllerDelegate: AnyObject{
    func didLogin()
}

protocol LogoutDelegate: AnyObject{
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    
    var username: String? {
        return loginView.usernameTextfield.text
    }
    
    var password: String? {
        return loginView.passwordTextfield.text
    }
    
    
    var errorMessage: String? = "" {
        didSet {
            configureView(withMessage: errorMessage)
        }
    }
    
    
    var subscriber: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        observe()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetUI()
    }
    
    func observe() {
        subscriber =  NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
            .sink { [weak self] notification in
                guard let self = self else {return}
                guard let _ = notification.object as? UITextField else {
                    return
                }
                self.errorMessage = nil
            }
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
    
    private func resetUI() {
        signInButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextfield.text = ""
        loginView.passwordTextfield.text = ""
        errorMessage = ""
    }
}

//MARK: - Actions

extension LoginViewController {
    
    @objc
    func signInTapped(sender: UIButton) {
        configureView(withMessage: nil)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else {return}
                self.delegate?.didLogin()
            }
            
        } else {
            configureView(withMessage: "Icorrect username / password")
        }
    }
    
    
    private func configureView(withMessage message: String?) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden =  message == nil
    }
}
