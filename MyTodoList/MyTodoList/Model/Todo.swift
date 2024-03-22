//
//  TodoList.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//

import Foundation
import UIKit

class Todo : CustomStringConvertible{
    
    var description: String {
        return "Todo - id: \(id), title: \(title), isCompleted: \(isCompleted), isImportant: \(isImportant), startDate: \(startDate ?? Date()), endDate: \(endDate ?? Date()), memo: \(memo), tag: \(tag), isOpen: \(isOpen)"
    }
    
    var id : Int
    var title : String
    var isCompleted : Bool = false
    var isImportant : Bool = false
    var startDate : Date?
    var endDate : Date?
    var memo : String
    var tag : [String] {
        didSet {
            updateTagDictionary(oldValue)
        }
    }
    var isOpen : Bool = false
    
    init(id: Int, title: String, isCompleted: Bool, isImportant: Bool, startDate: Date? = nil, endDate: Date? = nil, memo: String, tag: [String], isOpen: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.isImportant = isImportant
        self.startDate = startDate
        self.endDate = endDate
        self.memo = memo
        self.tag = tag
        self.isOpen = isOpen
    }
    
    deinit{
        print("deinit")
    }
}

extension Todo {
    static var todoID = 5
    
    static var list = [Todo(id: 0, title: "👇🏻 투두 눌러서 펼쳐보기!",isCompleted: false,isImportant: false, startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#투두","#펼쳐보기","#iOS"],isOpen : true),
                       Todo(id: 1, title: "✂️ 왼쪽 스와이프로 수정하기!",isCompleted: false,isImportant: false,startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST", tag: ["#수정하기"], isOpen: false),
                       Todo(id: 2, title: "🗑️ 오른쪽 스와이프로 삭제하기!",isCompleted: false,isImportant: false,startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#삭제하기"], isOpen: false),
                       Todo(id: 3, title: "⭐️ 별 표시 눌러서 강조하기!",isCompleted: false,isImportant: true, startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#별 꾸욱","#강조","#중요!"], isOpen: false),
                       Todo(id: 4, title: "✅ 체크박스 눌러서 완료 표시하기!",isCompleted: true,isImportant: false,startDate:Date(),endDate: Date(timeIntervalSinceNow: 300), memo: "TEST" ,tag: ["#체크박스","#완료!"], isOpen: false),
                       Todo(id: 5, title: "➕ 아래 + 버튼 눌러서 새로운 투두 추가하기",isCompleted: false,isImportant: false, startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#새로운투두","#추가하기"], isOpen: false),
    ]
    
    private func updateTagDictionary(_ oldValue : [String]) {
        let previousTags = Set(oldValue)
        let newTags = Set(tag)
        let removedTags = previousTags.subtracting(newTags)
        for removedTag in removedTags {
            Tag.tagDic[removedTag]!.todo.removeAll{ $0.id == self.id}
            if Tag.tagDic[removedTag]!.todo.isEmpty {
                Tag.tagDic[removedTag] = nil
            }
        }
    }
}
