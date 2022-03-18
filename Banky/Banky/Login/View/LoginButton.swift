//
//  LoginButton.swift
//  Banky
//
//  Created by Mohamed Elatabany on 18/03/2022.
//

import Foundation
import UIKit

protocol LoginButtonDelegate: AnyObject {
    func signInTapped(sender: UIButton)
}

class LoginButton: UIButton {
    
    
    weak var delegate: LoginButtonDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    convenience init(title: String) {
        self.init(frame: .zero)
        self.init(type: .system)
        self.setTitle(title, for: [])
    }
    
    func showIndicator() {
        self.configuration?.showsActivityIndicator = true
    }
    
    func hideIndicator() {
        self.configuration?.showsActivityIndicator = true
    }

    
}


extension LoginButton {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configuration = .filled()
        self.configuration?.imagePadding = 8
        self.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    }
    
    
    func animate(view: UIView) {
        self.alpha = 0
        let animator  = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            guard let self = self else {return}
            self.alpha     =  1
        }
        animator.startAnimation(afterDelay: 1.3)
        
    }
    

    
}



extension LoginButton {
    
    @objc
    func signInTapped(sender: UIButton) {
        delegate?.signInTapped(sender: sender)
    }
    
}
