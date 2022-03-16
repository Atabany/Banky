//
//  Decimal+Ext.swift
//  Banky
//
//  Created by Mohamed Elatabany on 17/03/2022.
//

import UIKit
extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

