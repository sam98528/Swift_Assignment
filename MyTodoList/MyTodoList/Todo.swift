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
    var isImportant : Bool
    var startDate : Date?
    var endDate : Date?
    var memo : String
    var tag : [String]
}

