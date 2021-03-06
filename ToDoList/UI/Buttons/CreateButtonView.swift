//
//  CreateButtonView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI

struct CreateButtonView: View {
    
    @Environment(\.colorScheme)
    var colorScheme
    
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            
            action()
            
        }, label: {
            Text(title).bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                .cornerRadius(13)
                .foregroundColor(Color.white)
                .padding(.trailing, 20)
        })
    }
}
