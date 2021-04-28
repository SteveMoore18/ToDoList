//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            
            case .background:
                do {
                    try persistenceController.container.viewContext.save()
                } catch {
                    fatalError("Error with saving core data background! \(error)")
                }
            case .inactive:
                print ("inactive")
            case .active:
                print ("active")
            @unknown default:
                fatalError()
            }
        }
    }
}
