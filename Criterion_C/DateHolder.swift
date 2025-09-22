//
//  DateHolder.swift
//  Criterion_C
//
//  Created by Twexcx on 22/09/2025.
//

import Foundation
import SwiftUI

final class DatehHolder: ObservableObject {
    @Published var date: Date

    init(date: Date = Date()) {
        self.date = date
    }
}
