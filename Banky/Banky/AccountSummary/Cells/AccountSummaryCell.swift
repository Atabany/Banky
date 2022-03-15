
//  AccountSummaryCell.swift
//  Banky
//
//  Created by Mohamed Elatabany on 15/03/2022.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let typeLabel: UILabel = UILabel()
    let underlineView: UIView = UIView()
    let nameLabel: UILabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    var chevronImageView = UIImageView()
    

    
    
    
    static let rowHeight: CGFloat = 100
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
//        balanceAmountLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        balanceAmountLabel.text = "17,5554$"



        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.alignment = .trailing
        balanceStackView.spacing = 0
        balanceStackView.axis = .vertical

        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.contentMode = .scaleAspectFit
        let chevronImage = UIImage.init(systemName: "chevron.right")?.withTintColor(K.colors.appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
//        chevronImageView.tintColor = K.colors.appColor

        
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
