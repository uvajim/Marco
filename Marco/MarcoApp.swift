//
//  MarcoApp.swift
//  Marco
//
//  Created by Jinming Liang on 6/5/23.
//

import SwiftUI

@main
struct MarcoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
