//
//  Date+Ext.swift
//  Banky
//
//  Created by Mohamed Elatabany on 19/03/2022.
//

import Foundation

extension Date {
    
    
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(abbreviation: "MDT")
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
    
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
    
}
