//
//  PFinanceApp.swift
//  PFinance
//
//  Created by Simon Ng on 11/9/2020.
//

import SwiftUI

@main
struct PFinanceApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            DashboardView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
