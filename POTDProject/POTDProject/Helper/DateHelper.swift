//
//  DateHelper.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

import Foundation

struct DateHelper {
    private static let buddhistOffset = 543

    private static func gregorianYear(from year: Int) -> Int {
        // ถ้าปีมากกว่า 2500 ถือว่าเป็น พ.ศ.
        return year > 2500 ? year - buddhistOffset : year
    }

    static func startOfMonth(month: Int, year: Int) -> Date {
        let gregorianYear = gregorianYear(from: year)

        let components = DateComponents(
            year: gregorianYear,
            month: month,
            day: 1
        )
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
