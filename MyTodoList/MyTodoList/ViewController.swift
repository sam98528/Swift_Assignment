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
        alert.addTextField { field in
                    
                }
        
        let confirm = UIAlertAction(title: "추가", style: .default){action in
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
        list.append(Todo(id: 1, title: "101112", isCompleted: false))
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
        //cell Switch ON, OFF 만들어놓고
        // ReloadData()
        return cell
    }
}

/*
if (IsCompletedSwitch.isOn){
    Title.attributedText = Title.text?.strikeThrough()
}
 
 if cell.IsCompletedSwitch.isOn {
     cell.Title.attributedText = cell.Title.text?.strikeThrough()
 }else{
     let originalString = cell.Title.text ?? ""
     let attributedString = NSMutableAttributedString(string: originalString)
     attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
     cell.Title.attributedText = attributedString
 }
*/


extension String {
    // 블로그 참고
    func strikeThrough() -> NSAttributedString {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            return attributeString
    }
}
