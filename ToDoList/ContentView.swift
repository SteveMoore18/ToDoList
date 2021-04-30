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
    
    @ObservedObject var mainMenuModel = MainMenuModel()
    
    // MARK: - body
    var body: some View {
        
        SearchBarView(text: $searchText) {
            // if user pressed cancel button
            searchText = ""
        } content: {
            
            ZStack {
                
                if tasks.count == 0 {
                    Text("Нет задач")
                        .font(.system(size: 26))
                        .foregroundColor(Color(.systemGray2))
                } else {
                    List {
                        ForEach (sortTasks(array: tasks)) { task in
                            
                            if task.title!.lowercased().contains(searchText) || searchText.isEmpty {
                                HStack {
                                    CheckboxCell(title: task.title ?? "Unknown task", isChecked: task.isChecked)
                                    Spacer()
                                    PriorityFlagView(priority: Int(task.priority))
                                }
                                
                            }
                        }
                        .onDelete(perform: deleteTask(at:))
                    }
                    
                }
            }.toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: { isNewTaskViewShow.toggle() }) {
                        Image(systemName: "plus.app")
                        Text("Новая задача")
                    }
                }
            }//Button("Delete all data", action: { deleteAllData() }
            .navigationBarItems(trailing: MainMenuView(mainMenuModel: mainMenuModel))
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
    
    private func sortTasks(array: FetchedResults<Task>) -> Array<Task> {
        
        switch mainMenuModel.sortMode {
        case .Name:
            
            return array.sorted(by: {
                mainMenuModel.sortBy == .Ascending ? ($0.title! < $1.title!) : ($0.title! > $1.title!)
            })

        case .Priority:
            
            return array.sorted(by: {
                mainMenuModel.sortBy == .Ascending ?  ($0.priority < $1.priority) : ($0.priority > $1.priority)
            })
            
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
