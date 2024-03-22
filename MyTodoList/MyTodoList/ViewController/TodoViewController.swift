//
//  ViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//



import UIKit

class TodoViewController: UIViewController{
    let font = "EF_Diary"
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var logoLabel: UILabel!
   
    @IBAction func TestClicked(_ sender: Any) {
        present(MainViewController(), animated: true)
    }
    @IBOutlet weak var test: UIButton!
    //var list = Todo.list

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tag.convertToTagDic(todos: Todo.list)
        toDoTableView.register(ToDoTableViewCell.nib(), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.layer.cornerRadius = 20
        toDoTableView.clipsToBounds = true
        toDoTableView.layer.borderWidth = 5
        toDoTableView.layer.borderColor = UIColor.label.cgColor
        
        logoLabel.font = UIFont(name: font, size: 45)
        
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.backgroundColor = UIColor.label
        button.tintColor = UIColor.systemBackground
        button.layer.cornerRadius = 40
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 5
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: toDoTableView.trailingAnchor, constant: -30).isActive = true
        button.bottomAnchor.constraint(equalTo: toDoTableView.bottomAnchor, constant: -50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        // Do any additional setup after loading the view.
        
    }
    @objc func buttonTapped() {
        let detailsViewController = DetailsViewController()
        detailsViewController.modalPresentationStyle = .automatic
        detailsViewController.modalTransitionStyle = .coverVertical
        detailsViewController.dataTransferDelegate = self
        //detailsViewController.list = self.list
        self.present(detailsViewController, animated: true, completion: nil)
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource,TableViewDelegate {
    func importantFlagClicked(index: Int) {
        Todo.list[index].isImportant = Todo.list[index].isImportant ? false : true
        self.toDoTableView.reloadData()
    }
    
    func buttonIsClicked(index: Int) {
        Todo.list[index].isCompleted = Todo.list[index].isCompleted ? false : true
        self.toDoTableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Todo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        Tag.convertToTagDic(todos: Todo.list)
        
        
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        let target = Todo.list[indexPath.row]
        
        cell.selectionStyle = .none
        cell.Title.font = UIFont(name: font, size: 16.0)
        cell.Title.text = target.title
        cell.index = indexPath.row
        //Todo.list[indexPath.row].id = indexPath.row
        cell.delegate = self
        cell.todo = target
        cell.tagCollectionView.reloadData()
        cell.tagCollectionView.backgroundColor = .clear
        //cell.tagDic = self.tagDic
        cell.CheckBoxButton.tintColor = UIColor.label
        if target.isOpen {
            cell.backgroundColor = .lightGray
        }else{
            cell.backgroundColor = UIColor.systemBackground
        }
        //cell.backgroundColor = .clear
        
        
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
            cell.ImportantFlagImageView.image = UIImage(systemName: "star.fill" )
        }else{
            cell.Title.textColor = UIColor.label
            cell.ImportantFlagImageView.image = UIImage(systemName: "star" )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let info = UIContextualAction(style: .destructive, title: "", handler: {(action, view, completionHandler) in
            let currentTodo = Todo.list[indexPath.row]
            let detailsViewController = DetailsViewController()
            detailsViewController.modalPresentationStyle = .automatic
            detailsViewController.modalTransitionStyle = .coverVertical
            detailsViewController.dataTransferDelegate = self
            //detailsViewController.list = Todo.list
            detailsViewController.currentTodo = currentTodo
            detailsViewController.index = indexPath.row
            self.present(detailsViewController, animated: true, completion: nil)
            completionHandler(true)
        })
        info.image = UIImage(systemName: "info.circle")
        info.backgroundColor = .gray
       return UISwipeActionsConfiguration(actions: [info])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let del = UIContextualAction(style: .destructive, title: "", handler: {(action, view, completionHandler) in
            Tag.updateTagsAfterTodoDeletion(deletedTodoID: Todo.list[indexPath.row].id)
            Todo.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            completionHandler(true)
        })
        del.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [del])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Todo.list[indexPath.row].isOpen{
            return 150
        }else{
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Tag.printTagDictionary()
        Todo.list[indexPath.row].isOpen.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension TodoViewController : DataTransferDelegate {
    func finishedEditing() {
        self.toDoTableView.reloadData()
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

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
