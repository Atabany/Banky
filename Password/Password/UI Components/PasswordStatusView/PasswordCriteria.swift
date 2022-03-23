//
//  PasswordCriteria.swift
//  Password
//
//  Created by Mohamed Elatabany on 22/03/2022.
//

import Foundation


struct PasswordCriteria {

    static func lengthCriteriaMet(_ text: String) -> Bool {
         text.count >= 8 && text.count <= 32
    }
    
    
    static func noSpacesCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    
    static func lengthAndNoSpacesMet(_ text: String) -> Bool {
        lengthCriteriaMet(text) && noSpacesCriteriaMet(text)
    }
    
    
    static func upperCaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    
    static func lowerCaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    
    static func digitCaseMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    
    static func specialCharacterMet(_ text: String) -> Bool {
        text.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil
    }

    
}
