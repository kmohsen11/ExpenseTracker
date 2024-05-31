//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Khaled Mohsen on 31/05/2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactinListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactinListVM)
        }
    }
}
