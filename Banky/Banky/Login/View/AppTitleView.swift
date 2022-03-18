//
//  AppTitleView.swift
//  Banky
//
//  Created by Mohamed Elatabany on 17/03/2022.
//


import UIKit
class AppTitleView: UIView {
    
    let appTitleLabel       = UILabel()
    let appSubtitleLabel    = UILabel()
    let stackView           = UIStackView()

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


extension AppTitleView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints         = false
        stackView.axis                                              = .vertical
        stackView.spacing                                           = 8

        
        
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        appTitleLabel.textColor = .label
        appTitleLabel.text  = "BANKY"
        appTitleLabel.translatesAutoresizingMaskIntoConstraints       = false
        appTitleLabel.textAlignment = .center
        appTitleLabel.adjustsFontForContentSizeCategory = true
        
        
        appSubtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appSubtitleLabel.textColor = .secondaryLabel
        appSubtitleLabel.text = "Best solution to track your accounts \n  your accounts Track them now"
        appSubtitleLabel.translatesAutoresizingMaskIntoConstraints       = false
        appSubtitleLabel.textAlignment = .center
        appSubtitleLabel.adjustsFontForContentSizeCategory = true
        appSubtitleLabel.numberOfLines = 0
        
        
        
    }
    
    
    func layout() {
        
        stackView.addArrangedSubview(appTitleLabel)
        stackView.addArrangedSubview(appSubtitleLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
        ])
        
        stackViewLeadingAnchor = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingEdgeOffScreen)
        stackViewLeadingAnchor?.isActive = true
        
    }
    
    
    func animate(view: UIView) {
        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            guard let self = self else {return}
            self.stackViewLeadingAnchor?.constant = self.leadingEdgeOnScreen
            view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        appTitleLabel.alpha = 0
        let animator2 = UIViewPropertyAnimator(duration: 1.3, curve: .easeInOut) { [weak self] in
            guard let self = self else {return}
            self.appTitleLabel.alpha = 1
        }
        animator2.startAnimation(afterDelay: 0.5)

        
        
    }
    
}

