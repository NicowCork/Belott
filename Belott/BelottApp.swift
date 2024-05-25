//
//  BelottApp.swift
//  Belott
//
//  Created by Nicolas Richard on 13/01/2022.
//

import SwiftUI

@main
struct BelottApp: App {
//    let persistenceController = PersistenceController.shared

    @StateObject var game = CalcModel()
    @StateObject var viewRouter = ViewRouter()
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
                .environmentObject(viewRouter)
                .environment(\.managedObjectContext, dataController.container.viewContext)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
