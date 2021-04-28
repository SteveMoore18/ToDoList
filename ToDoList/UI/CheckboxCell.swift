//
//  CheckboxCell.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI

struct CheckBox: View {
    
    @Binding var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .resizable()
            .foregroundColor(.blue)
            .frame(width: 22, height: 22)
    }
}

struct CheckboxCell: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>

    @State var title: String
    @State var isChecked = false

    var body: some View {
        HStack {
            
            CheckBox(isChecked: $isChecked)

            Text(title)
                .font(.system(size: 20))
                .padding(.leading, 8)


        }.onTapGesture {
            isChecked.toggle()
            // find task in core data by title and set checkbox
            tasks.first(where: { $0.title == title })?.isChecked = isChecked
        }
    }

}

