//
//  soteriaApp.swift
//  soteria
//
//  Created by melvin on 25/07/22.
//

import SwiftUI

@main
struct soteriaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
