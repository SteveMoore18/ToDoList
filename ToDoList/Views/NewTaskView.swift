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
    
    // MARK: - body
    var body: some View {
        
        VStack {
            
            TitleTextFieldView(placeholder: "Название", title: $title)
            
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
    }
    
}

//struct NewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//    }
//}
