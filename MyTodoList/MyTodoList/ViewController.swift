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
    
    
    var list : [Todo] = []
    
    
    @IBAction func MybuttonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message: "입력해주세요!", preferredStyle: .alert)
        alert.addTextField()
        
        let confirm = UIAlertAction(title: "추가", style: .destructive){action in
            if let textField = alert.textFields?.first {
                self.list.append(Todo(id: 1, title: textField.text!, isCompleted: false))
                self.MyTableView.reloadData()
            }
        }
        let close = UIAlertAction(title: "닫기", style: .destructive, handler: nil)
                
        alert.addAction(confirm)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list.append(Todo(id: 1, title: "123", isCompleted: false))
        list.append(Todo(id: 1, title: "234", isCompleted: false))
        list.append(Todo(id: 1, title: "456", isCompleted: false))
        list.append(Todo(id: 1, title: "789", isCompleted: false))
        MyTableView.delegate = self
        MyTableView.dataSource = self
        MyTableView.register(ToDoTableViewCell.nib(), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource,TableViewDelegate {
    
    func switchIsChanged(index: Int) {
        list[index].isCompleted = list[index].isCompleted ? false : true
        self.MyTableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        let target = list[indexPath.row]
        cell.Title.text = target.title
        cell.index = indexPath.row
        list[indexPath.row].id = indexPath.row
        cell.delegate = self
        if target.isCompleted == true {
            cell.Title.attributedText = cell.Title.text?.strikeThrough()
            cell.IsCompletedSwitch.setOn(true, animated: false)
        }else{
            cell.IsCompletedSwitch.setOn(false, animated: false)
            if let text = cell.Title.text {
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
                cell.Title.attributedText = attributedString
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let action = UIContextualAction(style: .normal, title: "swipe", handler: {(action, view, completionHandler) in
           print("Swiped") // 실행하고 싶은 내용
           completionHandler(true)
       })
       
       return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "swipe", handler: {(action, view, completionHandler) in
            self.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) // 실행하고 싶은 내용
            completionHandler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}



extension String {
    // 블로그 참고
    func strikeThrough() -> NSAttributedString {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            return attributeString
    }
}
