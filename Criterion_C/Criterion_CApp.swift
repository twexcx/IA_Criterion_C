//
//  Criterion_CApp.swift
//  Criterion_C
//
//  Created by Twexcx on 28/08/2025.
//

import SwiftUI

@main
struct Criterion_CApp: App {
    init() {
           // Set the color globally for all navigation bars
        UINavigationBar.appearance().tintColor = UIColor(named: "LIC")
       }
    var body: some Scene {
        WindowGroup {
            let dateHolder = DatehHolder()
            let deadlineStorage = DeadlineStorage()
            SplashView()
                .environmentObject(dateHolder)
                .environmentObject(deadlineStorage)
        }
    }
}
