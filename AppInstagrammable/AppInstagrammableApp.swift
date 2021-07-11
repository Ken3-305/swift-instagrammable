//
//  AppInstagrammableApp.swift
//  AppInstagrammable
//
//  Created by 松山直人 on 2021/07/06.
//

import SwiftUI

@main
struct AppInstagrammableApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
