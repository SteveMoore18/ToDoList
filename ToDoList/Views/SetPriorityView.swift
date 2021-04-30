//
//  SetPriorityView.swift
//  ToDoList
//
//  Created by Савелий Никулин on 29.04.2021.
//

import SwiftUI
import FloatingButton

struct SetPriorityView: View {
    
    @State var isOpen = false
    
    @State private var mainButtonColor: UIColor = .systemGray
    
    @Binding public var priority: Int
    
    private let priorityModel = PriorityModel()
    
    var body: some View {
        
        let mainButton = AnyView(Image(systemName: priority == 0 ? "flag.slash.fill" : "flag.fill").foregroundColor(Color(mainButtonColor)).opacity(0.9))
        
        
        let floatingButton = FloatingButton(mainButtonView: mainButton, buttons: createPriorityButtons(), isOpen: $isOpen)
            .straight()
            .direction(.right)
            .delays(delayDelta: 0.1)
            .spacing(10)
            .initialOpacity(0)
            .animation(.easeInOut)
        
        return floatingButton
        
    }
    
    private func createPriorityButtons() -> [AnyView] {
        
        var priorityButtons: [AnyView] = []
        
        for i in 0..<4 {
            let button = AnyView(
                SubmenuButton(buttonView: AnyView(Image(systemName: i == 0 ? "flag.slash.fill" : "flag.fill").foregroundColor(priorityModel.priorityColor[i]).opacity(0.9)),
                              action: {
                                priority = i
                                mainButtonColor = UIColor(priorityModel.priorityColor[i])
                                isOpen = false
                              })
            )
            priorityButtons.append(button)
        }
        
        return priorityButtons
    }
    
}

private struct SubmenuButton: View {
    
    var buttonView: AnyView
    var action: ()->() = {}
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            buttonView
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SetPriorityView_Previews: PreviewProvider {
    static var previews: some View {
        SetPriorityView( priority: .constant(0))
    }
}
