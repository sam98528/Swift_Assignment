//
//  TodoList.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//

import Foundation

struct Todo{
    var id : Int
    var title : String
    var isCompleted : Bool
}

extension Todo{
    static var data = [
        Todo(id: 1, title: "123", isCompleted: false),
        Todo(id: 1, title: "123", isCompleted: false),
        Todo(id: 1, title: "123", isCompleted: false),
        Todo(id: 1, title: "123", isCompleted: false),
        Todo(id: 1, title: "123", isCompleted: false)
    ]
}



