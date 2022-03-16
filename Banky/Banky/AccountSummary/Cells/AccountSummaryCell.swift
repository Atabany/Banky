
//  AccountSummaryCell.swift
//  Banky
//
//  Created by Mohamed Elatabany on 15/03/2022.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case banking
        case creditCard
        case investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        
        var accountTypeValue: String {
            return self.accountType.rawValue.firstCharacterUpperCase() ?? ""
        }
        
        
    }
    
    var viewModel: ViewModel? = nil
    
    let typeLabel: UILabel = UILabel()
    let underlineView: UIView = UIView()
    let nameLabel: UILabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    var chevronImageView = UIImageView()
    
    static let rowHeight: CGFloat = 112
    static let reuseId = AccountSummaryCell.description()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension AccountSummaryCell {
    
    private func setup() {
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account Type"
        
        underlineView.backgroundColor = K.colors.appColor
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = "Account Name"
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.text = "Current balance"
        
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.alignment = .trailing
        balanceStackView.spacing = 0
        balanceStackView.axis = .vertical

        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.contentMode = .scaleAspectFit
        let chevronImage = UIImage.init(systemName: "chevron.right")?.withTintColor(K.colors.appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage

        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")

        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
        
    }
    
    private func layout() {

        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            
            
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier:  0),
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier:  1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1),

        ])
    }
}


extension AccountSummaryCell {
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}


extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        self.viewModel = vm
        
        typeLabel.text = vm.accountTypeValue
        nameLabel.text = vm.accountName
        switch vm.accountType {
        case .banking:
            underlineView.backgroundColor = K.colors.appColor
            balanceLabel.text = "Current balance"
        case .creditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current balance"
        case .investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}


