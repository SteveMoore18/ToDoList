//
//  ContentView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>
    
    @State var isNewTaskViewShow = false

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach (tasks) { task in
                        CheckboxCell(title: task.title ?? "Unknown task", isChecked: task.isChecked)
                    }
                }
                .toolbar(content: {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Button(action: {
                            isNewTaskViewShow.toggle()
                        }, label: {
                            Image(systemName: "plus.app")
                            Text("Новая задача")
                        })
                    }
                })
                .navigationBarItems(trailing: Button("Delete all data", action: {
                    for i in tasks {
                        viewContext.delete(i)
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        fatalError("Error with saving new task! \(error)")
                    }
                }))
                .navigationTitle("Задачи")
                .sheet(isPresented: $isNewTaskViewShow, content: {
                    NewTaskView(isNewTaskViewShow: $isNewTaskViewShow)
                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                })
            }
        }
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
