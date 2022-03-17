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

        
        
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        appTitleLabel.textColor = .label
        appTitleLabel.text  = "BANKY"
        appTitleLabel.translatesAutoresizingMaskIntoConstraints       = false
        appTitleLabel.textAlignment = .center
        
        appSubtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        appSubtitleLabel.textColor = .secondaryLabel
        appSubtitleLabel.text = "Best solution to track your accounts"
        appSubtitleLabel.translatesAutoresizingMaskIntoConstraints       = false
        appSubtitleLabel.textAlignment = .center

    }
    
    
    func layout() {
        
        stackView.addArrangedSubview(appTitleLabel)
        stackView.addArrangedSubview(appSubtitleLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            
        ])

        
        
    }
    
}

