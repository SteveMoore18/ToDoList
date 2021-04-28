//
//  NewTaskView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI
import CoreData

struct NewTaskView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>
    
    @Binding var isNewTaskViewShow: Bool
    
    @State private var title = ""
    
    var body: some View {
        
        VStack {
            
            
            TextField("Название", text: $title)
                .padding()
                .background(Color.init(#colorLiteral(red: 0.9160023411, green: 0.9160023411, blue: 0.9160023411, alpha: 1)))
                .cornerRadius(13)
                .padding()
            
            HStack {
                
                Button(action: {
                    isNewTaskViewShow = false
                }, label: {
                    Text("Отмена").bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.blue, lineWidth: 1))
                            .padding(.leading, 20)
                })
                
                Button(action: {
                    
                    let newTask = Task(context: viewContext)
                    newTask.isChecked = false
                    newTask.title = title
                    
                    do {
                        try viewContext.save()
                    } catch {
                        fatalError("Error with saving new task! \(error)")
                    }
                    
                    
                    isNewTaskViewShow = false
                    
                }, label: {
                    Text("Создать").bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(13)
                            .foregroundColor(Color.white)
                            .padding(.trailing, 20)
                })
                
            }
            
        }
        
    }    
}

//struct NewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//    }
//}
