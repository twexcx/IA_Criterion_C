//
//  StudySession.swift
//  Criterion_C
//
//  Created by Twexcx on 22/09/2025.
//


// StudySession.swift
import Foundation


struct StudySession: Identifiable, Equatable, Codable {
    let id: UUID
    let deadlineID: UUID
    let title: String
    let date: Date        // the day this session is scheduled for (start-of-day recommended)
    let indexInDay: Int   // optional ordering for that day (0,1,2,...)

    init(id: UUID = UUID(), deadlineID: UUID, title: String, date: Date, indexInDay: Int = 0) {
        self.id = id
        self.deadlineID = deadlineID
        self.title = title
        self.date = date
        self.indexInDay = indexInDay
    }
}
