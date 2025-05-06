//
//  NotesAppIphoneApp.swift
//  NotesAppIphone
//
//  Created by Rakesh Yelakanti on 05/05/25.
//

import SwiftUI

@main
struct NotesAppIphoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
