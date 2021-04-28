//
//  CancelButton.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI

struct CancelButtonView: View {
    
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            //isNewTaskViewShow = false
            action()
        }, label: {
            Text(title).bold()
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.blue, lineWidth: 1))
                .padding(.leading, 20)
        })
    }
}
