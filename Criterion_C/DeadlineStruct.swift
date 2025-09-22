//
//  EventStruct.swift
//  Criterion_C
//
//  Created by Twexcx on 21/09/2025.
//

import Foundation

enum Priority: Int, CaseIterable, Codable {
    case oneStar = 1, twoStars, threeStars
    
    // Return a string of "*" characters corresponding to the priority level.
    var symbol: String{
        return String(repeating: "*", count: rawValue)
    }
}
struct LocalDeadline: Identifiable, Equatable, Codable {
    let id: UUID        // unique ID for identification
    var title: String
    var startDate: Date
    var endDate: Date
    var priority: Priority
}
