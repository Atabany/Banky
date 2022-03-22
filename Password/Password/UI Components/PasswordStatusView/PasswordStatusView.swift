//
//  PasswordStatusView.swift
//  Password
//
//  Created by Mohamed Elatabany on 21/03/2022.
//

import UIKit

class PasswordStatusView: UIView {
    
    let stackView = UIStackView()
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    let criteriaLabel = UILabel()
    
    // Used to determine if we reset criteria back to empty state
    var shouldResetCriteria: Bool = true
    
    var criteriaMet: Bool {
        return lengthCriteriaView.isCriteriaMet &&
        uppercaseCriteriaView.isCriteriaMet &&
        lowerCaseCriteriaView.isCriteriaMet &&
        digitCriteriaView.isCriteriaMet &&
        specialCharacterCriteriaView.isCriteriaMet
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
    private func makeCriteriaMessage() -> NSAttributedString {
        
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        
        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))
        
        return attrText
    }
    
    
}


extension PasswordStatusView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .tertiarySystemFill
        layer.cornerRadius = 5
        clipsToBounds = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
    }
    
    
    func layout() {
        
        addSubview(stackView)
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
        ])
        
    }
    
}

//MARK: - Actions
extension PasswordStatusView {
    
    
    func updateDiplay(_ text: String) {
        let lengthAndNoSpacesMet = PasswordCriteria.lengthAndNoSpacesMet(text)
        let upperCaseMet =  PasswordCriteria.upperCaseMet(text)
        let lowerCaseMet =  PasswordCriteria.lowerCaseMet(text)
        let digitMet =  PasswordCriteria.digitCaseMet(text)
        let speicalCharacterMet =  PasswordCriteria.specialCharacterMet(text)
        
        
        
        
        if shouldResetCriteria {
            lengthAndNoSpacesMet
            ? lengthCriteriaView.isCriteriaMet = true
            : lengthCriteriaView.reset()
            
            upperCaseMet
            ? uppercaseCriteriaView.isCriteriaMet = true
            : uppercaseCriteriaView.reset()
            
            
            lowerCaseMet
            ? lowerCaseCriteriaView.isCriteriaMet = true
            : lowerCaseCriteriaView.reset()
            
            
            digitMet
            ? digitCriteriaView.isCriteriaMet = true
            : digitCriteriaView.reset()
            
            speicalCharacterMet
            ? specialCharacterCriteriaView.isCriteriaMet = true
            : specialCharacterCriteriaView.reset()
            
        } else {
            lengthCriteriaView.isCriteriaMet = lengthAndNoSpacesMet
            uppercaseCriteriaView.isCriteriaMet = upperCaseMet
            lowerCaseCriteriaView.isCriteriaMet = lowerCaseMet
            digitCriteriaView.isCriteriaMet = digitMet
            specialCharacterCriteriaView.isCriteriaMet = speicalCharacterMet
        }
        
    }
    
    
    
    func validate(_ text: String) -> Bool {
        
        let upperCaseMet =  PasswordCriteria.upperCaseMet(text)
        let lowerCaseMet =  PasswordCriteria.lowerCaseMet(text)
        let digitMet =  PasswordCriteria.digitCaseMet(text)
        let speicalCharacterMet =  PasswordCriteria.specialCharacterMet(text)
        
        let checkable = [upperCaseMet, lowerCaseMet, digitMet, speicalCharacterMet]
        
        let metCriteria = (checkable.filter {$0}).count >= 3
        let lengthAndNoSpacesMet = PasswordCriteria.lengthAndNoSpacesMet(text)

        return metCriteria && lengthAndNoSpacesMet
    }
    
    
    
    func reset() {
        
        lengthCriteriaView.reset()
        uppercaseCriteriaView.reset()
        lowerCaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }
    
}
