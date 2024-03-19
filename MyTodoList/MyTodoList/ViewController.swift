//
//  ViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//



import UIKit

class ViewController: UIViewController{
    let font = "EF_Diary"
    @IBOutlet weak var MyButton: UIButton!
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var LogoLabel: UILabel!
    var addButton: UIButton!
    
    var list : [Todo] = []
    
    
    @IBAction func MybuttonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message: "입력해주세요!", preferredStyle: .alert)
        alert.addTextField()
        
        let confirm = UIAlertAction(title: "추가", style: .default){action in
            if let textField = alert.textFields?.first {
                self.list.append(Todo(id: 1, title: textField.text!, isCompleted: false, isImportant: false))
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
        
        list.append(Todo(id: 1, title: "강의 듣기", isCompleted: false, isImportant: true))
        list.append(Todo(id: 1, title: "과제 1번 완성하기!", isCompleted: false, isImportant: false))
        list.append(Todo(id: 1, title: "강아지 산책하기", isCompleted: false, isImportant: false))
        list.append(Todo(id: 1, title: "어제 못본 나는 솔로보기", isCompleted: false, isImportant: false))
        MyTableView.delegate = self
        MyTableView.dataSource = self
        MyTableView.register(ToDoTableViewCell.nib(), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        MyTableView.layer.cornerRadius = 20
        MyTableView.clipsToBounds = true
        MyTableView.backgroundView = UIImageView(image: UIImage(named: "paper-texture"))
        LogoLabel.font = UIFont(name: font, size: 45)
        
        // Do any additional setup after loading the view.
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource,TableViewDelegate {
   
    
    func buttonIsClicked(index: Int) {
        list[index].isCompleted = list[index].isCompleted ? false : true
        self.MyTableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        let target = list[indexPath.row]
        
        cell.selectionStyle = .none
        
        
        cell.Title.font = UIFont(name: font, size: 15.0)
        cell.Title.text = target.title
        cell.index = indexPath.row
        list[indexPath.row].id = indexPath.row
        
        cell.backgroundColor = .clear
        
        cell.delegate = self
        if target.isCompleted == true {
            cell.Title.attributedText = cell.Title.text?.strikeThrough()
            cell.CheckBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }else{
            cell.CheckBoxButton.setImage(UIImage(systemName: "square"), for: .normal)
            if let text = cell.Title.text {
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
                cell.Title.attributedText = attributedString
            }
        }
        
        
        if target.isImportant == true {
            cell.Title.textColor = .red
        }else{
            cell.Title.textColor = .black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let action = UIContextualAction(style: .normal, title: "", handler: {(action, view, completionHandler) in
           self.list[indexPath.row].isImportant = self.list[indexPath.row].isImportant ? false : true
           tableView.reloadRows(at: [indexPath], with: .automatic)
           tableView.reloadData()
           completionHandler(true)
       })
        action.backgroundColor = .systemBlue
        action.image = UIImage(systemName: "star.fill")
       return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "", handler: {(action, view, completionHandler) in
            self.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            completionHandler(true)
        })
        action.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list[indexPath.row])
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
