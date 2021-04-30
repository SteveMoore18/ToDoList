//
//  SortMenuView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 30.04.2021.
//

import SwiftUI

private struct ButtonWithCheckmark: View {
    
    var text: String
    var action: () -> ()
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: action)
        {
            HStack {
                if isChecked { Image(systemName: "checkmark") }
                Text(text)
            }
        }
        
    }
    
}

struct SortMenuView: View {
    
    var mainMenuModel: MainMenuModel
    
    // This is need for set checkmark on buttons when clicked
    @State private var onNameButtonClicked = true
    @State private var onPriorityButtonClicked = false
    
    @State private var onAscendingButtonClicked = true
    @State private var onDescendingButtonClicked = false
    
    var body: some View {
        
        Menu {
            
            ButtonWithCheckmark(text: "Названию", action: {
                mainMenuModel.sortMode = .Name
                onNameButtonClicked = true
                onPriorityButtonClicked = false
            }, isChecked: $onNameButtonClicked)
            
            ButtonWithCheckmark(text: "Приоритету", action: {
                mainMenuModel.sortMode = .Priority
                onNameButtonClicked = false
                onPriorityButtonClicked = true
            }, isChecked: $onPriorityButtonClicked)
            
            Divider()
            
            ButtonWithCheckmark(text: "По возрастанию", action: {
                mainMenuModel.sortBy = .Ascending
                onAscendingButtonClicked = true
                onDescendingButtonClicked = false
            }, isChecked: $onAscendingButtonClicked)
            
            ButtonWithCheckmark(text: "По убыванию", action: {
                mainMenuModel.sortBy = .Descending
                onAscendingButtonClicked = false
                onDescendingButtonClicked = true
            }, isChecked: $onDescendingButtonClicked)

        } label: {
            Text("Сортировать")
            Image(systemName: "arrow.up.arrow.down")
            
        }
        
    }
    
}
