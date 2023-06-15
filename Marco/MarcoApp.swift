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
            HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext) 
        }
    }
}
