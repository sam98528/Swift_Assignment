//
//  Tag.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/22/24.
//

import Foundation
import UIKit





struct Tag {
    var tagName : String
    var color : UIColor
    var todo : [Todo]
}

extension Tag {
    /*static var tagDic : [String : Tag] = [ "#투두" : Tag(tagName: "#투두", color: UIColor(hexCode: "8FCB9B"), todo: []),
                                           "#iOS" : Tag(tagName: "#iOS", color: UIColor(hexCode: "122222"),todo: []),
                                           "#펼쳐보기" : Tag(tagName: "#펼쳐보기", color: UIColor(hexCode: "23DEFC"),todo: []),
                                           "#수정하기" : Tag(tagName: "#수정하기", color: UIColor(hexCode: "125BCB"),todo: []),
                                           "#삭제하기" : Tag(tagName: "#삭제하기", color: UIColor(hexCode: "FA123B"),todo: []),
                                           "#별 꾸욱" : Tag(tagName: "#별 꾸욱", color: UIColor(hexCode: "772747"),todo: []),
                                           "#강조" : Tag(tagName: "#강조", color: UIColor(hexCode: "FA123B"),todo: []),
                                           "#중요!" : Tag(tagName: "#중요!", color: UIColor(hexCode: "89AB77"),todo: []),
                                           "#체크박스" : Tag(tagName: "#체크박스", color: UIColor(hexCode: "12FCB2"),todo: []),
                                           "#완료!" : Tag(tagName: "#완료!", color: UIColor(hexCode: "2FCA9B"),todo: []),
                                           "#새로운투두" : Tag(tagName: "#새로운투두", color: UIColor(hexCode: "125BCB"),todo: []),
                                           "#추가하기" : Tag(tagName: "#추가하기", color: UIColor(hexCode: "99CCDE"),todo: []),
                                           
                                        ]
     */
    
    static var tagDic : [String : Tag] = [:]
    
    static func convertToTagDic(todos: [Todo]) {
            for todo in todos {
                for tag in todo.tag {
                    if let existingTag = self.tagDic[tag] {
                        var updatedTodoList = existingTag.todo
                        updatedTodoList.append(todo)
                        let updatedTag = Tag(tagName: existingTag.tagName, color: existingTag.color, todo: updatedTodoList)
                        self.tagDic[tag] = updatedTag
                    } else {
                        let randomColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
                        let newTag = Tag(tagName: tag, color: randomColor, todo: [todo])
                        self.tagDic[tag] = newTag
                    }
                }
            }
        }
}
