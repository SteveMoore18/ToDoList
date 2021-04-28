//
//  TitleTextFieldView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 28.04.2021.
//

import SwiftUI

struct TitleTextFieldView: View {
    var placeholder: String
    @Binding var title: String
    var body: some View {
        TextField(placeholder, text: $title)
            .padding()
            .background(Color.init(#colorLiteral(red: 0.9160023411, green: 0.9160023411, blue: 0.9160023411, alpha: 1)))
            .cornerRadius(13)
            .padding()
    }
}
