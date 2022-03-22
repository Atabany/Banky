//
//  PasswordTextField.swift
//  Password
//
//  Created by Mohamed Elatabany on 21/03/2022.
//


import UIKit

protocol PasswordTextfieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextfield)
    func editingDidEnd(_ sender: PasswordTextfield)
}


class PasswordTextfield: UIView {
    
    
    
    
    
    
    /**
            A function one passes in to do custom validation on the text field
                    - Parameter: textValue: The value of text to validate
                    - Returns: A Bool indicating whether text is valid, and if not a string containing an error message
     */
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill")!)
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let divderView = UIView()
    let errorLabel = UILabel()
    
    
    weak var delegate: PasswordTextfieldDelegate?
    var placeHolderText: String
    var customValidatoin: CustomValidation?
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue  }
    }
    
    
    init(placeHolderText: String) {
        
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
    
    
}


extension PasswordTextfield {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // true
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                             attributes: [.foregroundColor: UIColor.secondaryLabel])
        
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        
        

        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        
        divderView.translatesAutoresizingMaskIntoConstraints = false
        divderView.backgroundColor = UIColor.separator
        
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.text = "your password must meet the requirements below."
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true

        
    }
    
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(divderView)
        addSubview(errorLabel)

        // Lock
        NSLayoutConstraint.activate([
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
        ])
        
        
        // Textfield
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),

        ])
        
        // eye Button
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        
        
        
        // Divider
        NSLayoutConstraint.activate([
            divderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            divderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            divderView.heightAnchor.constraint(equalToConstant: 1),
            divderView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1)
        ])
        
        
        
        // Error label
        NSLayoutConstraint.activate([
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: divderView.bottomAnchor, constant: 4)
        ])
        

        
        
        
        
        // CHCR
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)

        
        
        
                
    }
    
}

//MARK: - Actions
extension PasswordTextfield {
    
    @objc
    func togglePasswordView() {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        errorLabel.isHidden = true
        delegate?.editingChanged(self)
    }
    
}


//MARK: - UITextfield delegate
extension PasswordTextfield: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

}


//MARK: - Validation
extension PasswordTextfield {
    
//    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    func validate() -> Bool {
        if let customValidation = customValidatoin,
            let customValidationResult = customValidation(text),
           customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    
    private func showError(_ errorMessage: String) {
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
    }
    
    
    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    
}


