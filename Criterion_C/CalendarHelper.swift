//
//  CalendarHelper.swift
//  Criterion_C
//
//  Created by Twexcx on 03/09/2025.
//

import Foundation

class CalendarHelper
{
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_ date: Date) -> String
    {
        dateFormatter.dateFormat = "LLL yyyy"
        return dateFormatter.string(from:date) //returns the date format (e.g. Wed 2025)
    }
    func minusMonth(_ date: Date) -> Date
    {
        
        return calendar.date(byAdding: .month, value: -1, to: date)! //switches the month to the previous onw
    }
    func plusMonth(_ date: Date) -> Date
    {
        
        return calendar.date(byAdding: .month, value: 1, to: date)! //switches the month to the next one
    }
    func daysInMonth(_ date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)! //number of days for a given month
        return range.count
    }
    func dayOfMonth(_ date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    func firstOfMonth(_ date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
}
