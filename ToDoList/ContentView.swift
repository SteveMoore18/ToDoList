//
//  ContentView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Core data
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>
    
    @State var isNewTaskViewShow = false
    
    @State var searchText = ""
    
    // MARK: - body
    var body: some View {
        
        SearchBarView(text: $searchText) {
            // if user pressed cancel button
            searchText = ""
        } content: {
            List {
                ForEach (tasks) { task in
                    
                    if task.title!.lowercased().contains(searchText) || searchText.isEmpty {
                        CheckboxCell(title: task.title ?? "Unknown task", isChecked: task.isChecked)
                    }
                }
                .onDelete(perform: deleteTask(at:))
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: { isNewTaskViewShow.toggle() }) {
                        Image(systemName: "plus.app")
                        Text("Новая задача")
                    }
                }
            }
            .navigationBarItems(trailing: Button("Delete all data", action: { deleteAllData() }))
            .navigationTitle("Задачи")
            .sheet(isPresented: $isNewTaskViewShow) {
                NewTaskView(isNewTaskViewShow: $isNewTaskViewShow)
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
        }
    }
    
    // MARK: - private functions
    private func deleteAllData() {
        tasks.forEach { viewContext.delete($0) }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { viewContext.delete(tasks[$0]) }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
