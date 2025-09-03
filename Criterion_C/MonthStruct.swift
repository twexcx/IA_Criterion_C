//
//  MonthStruct.swift
//  Criterion_C
//
//  Created by Twexcx on 03/09/2025.
//

import Foundation

struct MonthStruct
{
    var monthType: MonthType
    var dayInt : Int
    func day() -> String
    {
        return String(dayInt)
    }
}

enum MonthType
{
    case previous
    case current
    case next
}
