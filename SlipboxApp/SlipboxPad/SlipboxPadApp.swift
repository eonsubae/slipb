//
//  SlipboxPadApp.swift
//  SlipboxPad
//
//  Created by KRITSSEAN on 2021/03/20.
//

import SwiftUI

@main
struct SlipboxPadApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
