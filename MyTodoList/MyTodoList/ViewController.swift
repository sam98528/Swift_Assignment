//
//  ViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var MyButton: UIButton!
    @IBOutlet weak var MyTableView: UITableView!
    let list = Todo.data
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        list.append(Todo(id: 1, title: "123", isCompleted: false))
        list.append(Todo(id: 1, title: "234", isCompleted: false))
        list.append(Todo(id: 1, title: "456", isCompleted: false))
        list.append(Todo(id: 1, title: "789", isCompleted: false))
        list.append(Todo(id: 1, title: "101112", isCompleted: false))
        */
        MyTableView.delegate = self
        MyTableView.dataSource = self
        MyTableView.register(ToDoTableViewCell.nib(), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        let target = list[indexPath.row]
        cell.Title.text = target.title
        return cell
    }
}
