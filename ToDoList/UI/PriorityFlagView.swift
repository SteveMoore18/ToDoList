//
//  PriorityView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 29.04.2021.
//

import SwiftUI

struct PriorityFlagView: View {
    
    var priority: Int
    
    private let priorityModel = PriorityModel()
    
    var body: some View {
        Image(systemName: "flag.fill")
            .foregroundColor(priorityModel.priorityColor[priority])
            .opacity(priority == 0 ? 0 : 0.9) // if there is no priority, hide the flag
    }
    
}
