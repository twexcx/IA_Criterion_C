//
//  DateScrollerView.swift
//  Criterion_C
//
//  Created by Twexcx on 03/09/2025.
//

import SwiftUI

struct DateScrollerView: View {
    @EnvironmentObject var dateHolder: Dateholder
    var body: some View {
        HStack{
            Spacer()
            Button(action: previousMonth)
            {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
                    .foregroundStyle(.LIC)
            }
            Text(CalendarHelper().monthYearString(dateHolder.date))
                .font(.custom("Caveat-SemiBold", size: 30))
                .animation(.none)
                .frame(maxWidth: .infinity)
            Button(action: nextMonth)
            {
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
                    .foregroundStyle(.LIC)

            }
            Spacer()
        }
    }
    func previousMonth()
    {
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }
    func nextMonth()
    {
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}
