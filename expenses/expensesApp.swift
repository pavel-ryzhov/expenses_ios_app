//
//  expensesApp.swift
//  expenses
//
//  Created by pavel on 14/07/2024.
//

import SwiftUI
import SwiftData

@main
struct expensesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for: Symbol.self)
        }
    }
}
