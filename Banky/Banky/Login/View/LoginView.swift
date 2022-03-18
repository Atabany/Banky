
//
//  LoginView.swift
//  Banky
//
//  Created by Mohamed Elatabany on 13/03/2022.
//


import UIKit
class LoginView: UIView {
    
    
    let stackView           = UIStackView()
    let usernameTextfield   = UITextField()
    let passwordTextfield   = UITextField()
    let dividerView         = UIView()
    
    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var stackViewLeadingAnchor: NSLayoutConstraint?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    
    
}


extension LoginView {
    
    func style() {
        
        translatesAutoresizingMaskIntoConstraints                   = false
        backgroundColor                                             = .secondarySystemFill

        stackView.translatesAutoresizingMaskIntoConstraints         = false
        stackView.axis                                              = .vertical
        stackView.spacing                                           = 8

    
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.delegate                                  = self
        usernameTextfield.placeholder                               = "username"
        
        
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.delegate                                  = self
        passwordTextfield.placeholder                               = "password"
        passwordTextfield.isSecureTextEntry                         = true
        passwordTextfield.enablePasswordToggle()
        
        
        dividerView.translatesAutoresizingMaskIntoConstraints       = false
        dividerView.backgroundColor                                 = .secondarySystemFill

        layer.cornerRadius                                          = 5
        clipsToBounds                                               = true
        
        
    }
    
    
    func layout() {
        
        


        
        stackView.addArrangedSubview(usernameTextfield)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextfield)
        

        addSubview(stackView)
        
        


        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            
        ])
        
        stackViewLeadingAnchor = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingEdgeOffScreen)
        stackViewLeadingAnchor?.isActive = true

        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        

    }
    
    
    func animate(view: UIView) {
        alpha = 0

        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            guard let self = self else {return}
            self.stackViewLeadingAnchor?.constant = self.leadingEdgeOnScreen
            view.layoutIfNeeded()
        }
        animator1.startAnimation(afterDelay: 0.6)
        
        let animator2 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            guard let self = self else {return}
            self.alpha     =  1
        }
        animator2.startAnimation(afterDelay: 1)
        
    }

}



extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextfield.endEditing(true)
        passwordTextfield.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

}
