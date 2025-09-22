//
//  StudyScedule.swift
//  Criterion_C
//
//  Created by Twexcx on 22/09/2025.
//

import Foundation

func generateStudySchedule(from deadlines: [LocalDeadline]) -> [Date: [StudySession]]
{
    var schedule: [Date: [StudySession]] = [:]
    let cal = Calendar.current
    let now = Date()

    let upcoming = deadlines
        .filter { $0.endDate >= now && $0.estimatedStudyTime > 0 }
        .sorted
        {
            if cal.isDate($0.endDate, equalTo: $1.endDate, toGranularity: .day)
            {
                return $0.priority.rawValue > $1.priority.rawValue
            }
            return $0.endDate < $1.endDate
        }

    for d in upcoming
    {
        let blocks = Int(ceil(Double(d.estimatedStudyTime) / 25.0))
        guard blocks > 0 else { continue }

        let startDay = cal.startOfDay(for: max(now, d.startDate))
        let endDay   = cal.startOfDay(for: d.endDate)
        guard let diff = cal.dateComponents([.day], from: startDay, to: endDay).day else { continue }
        let days = max(0, diff) + 1

        let base = blocks / days
        let rem  = blocks % days

        for offset in 0..<days
        {
            guard let day = cal.date(byAdding: .day, value: offset, to: startDay) else { continue }
            let count = base + (offset < rem ? 1 : 0)
            if count > 0
            {
                let existingCount = schedule[day]?.count ?? 0
                let sessions = (0..<count).map
                {
                    i in
                    StudySession(deadlineID: d.id, title: d.title, date: day, indexInDay: existingCount + i)
                }
                schedule[day, default: []].append(contentsOf: sessions)
            }
        }
    }
    return schedule
}
