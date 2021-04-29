//
//  NewTaskView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI
import CoreData

struct NewTaskView: View {
    
    // MARK: - Core data
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>
    
    // MARK: - View setup
    @Binding var isNewTaskViewShow: Bool
    
    @State private var title = ""
    
    @State private var priority = 0
    
    // MARK: - body
    var body: some View {
        
        VStack {
            
            TitleTextFieldView(placeholder: "Название", title: $title)
                .padding(.bottom, -15)
            
            HStack {
                SetPriorityView(priority: $priority)
                    .font(.system(size: 26))
                    .frame(width: 30, height: 30)
                    .padding()
                    Spacer()
            }
            
            
            HStack {
                
                CancelButtonView(title: "Назад", action: { isNewTaskViewShow = false })
                
                CreateButtonView(title: "Создать") {
                    createNewTask()
                    isNewTaskViewShow = false
                }
                
            }
            
        }
    }
    
    
    // MARK: - private functions
    private func createNewTask() {
        let newTask = Task(context: viewContext)
        newTask.isChecked = false
        newTask.title = title
        newTask.priority = Int16(priority)
    }
    
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(isNewTaskViewShow: .constant(true)).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
