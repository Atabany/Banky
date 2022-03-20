//
//  ProfileModel.swift
//  Banky
//
//  Created by Mohamed Elatabany on 20/03/2022.
//

import Foundation

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName  = "last_name"
    }
}
