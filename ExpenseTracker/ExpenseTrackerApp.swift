//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 13.5.2023.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
