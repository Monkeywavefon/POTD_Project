//
//  DateHelper.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import Foundation

struct DateHelper {
    
    static func startOfMonth(month: Int, year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: 1)
        return Calendar.current.date(from: components)!
    }
    
    static func endOfMonth(month: Int, year: Int) -> Date {
        let start = startOfMonth(month: month, year: year)
        return Calendar.current.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: start
        )!
    }
}
