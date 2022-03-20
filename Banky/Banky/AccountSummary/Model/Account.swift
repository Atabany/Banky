//
//  Account.swift
//  Banky
//
//  Created by Mohamed Elatabany on 20/03/2022.
//

import Foundation

enum AccountType: String, Codable {
    case banking = "Banking"
    case creditCard = "CreditCard"
    case investment = "Investment"

}


struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        return Account(id: "1", type: .banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }

}
