//
//  MainMenuView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 30.04.2021.
//

import SwiftUI


struct MainMenuView: View {
    
    var mainMenuModel: MainMenuModel
    
    var body: some View {
        
        Menu {
            
            SortMenuView(mainMenuModel: mainMenuModel)
                

        } label: {
            Image(systemName: "ellipsis.circle")
                .font(.system(size: 24))
                .foregroundColor(Color(.systemBlue))
        }

    }
    
}

