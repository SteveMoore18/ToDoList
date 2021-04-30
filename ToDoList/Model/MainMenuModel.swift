//
//  MainMenuModel.swift
//  ToDoList
//
//  Created by Савелий Никулин on 30.04.2021.
//

import SwiftUI

enum SortMode {
    case Name
    case Priority
}

enum SortBy {
    case Ascending
    case Descending
}

class MainMenuModel: ObservableObject {
    
    @Published public var sortMode: SortMode
    @Published public var sortBy: SortBy
    
    init() {
        sortMode = .Name
        sortBy = .Ascending
    }
    
}
