//
//  ViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//



import UIKit

class ViewController: UIViewController{
    let font = "EF_Diary"
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var LogoLabel: UILabel!
   
    
    var list : [Todo] = [Todo(id: 1, title: "왼쪽 스와이프로 강조하기!", isCompleted: false, isImportant: true,startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST", tag: ["#테스트"]),
                         Todo(id: 1, title: "오른쪽 스와이프로 삭제하기!", isCompleted: false, isImportant: false,startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#테스트1"]),
                         Todo(id: 1, title: "강아지 산책하기!", isCompleted: false, isImportant: false,startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#테스트2","#sdas","#123"]),
                         Todo(id: 1, title: "과제 마무리하기!", isCompleted: false, isImportant: false,startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#테스트","#123","#123"]),
                         ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTableView.register(ToDoTableViewCell.nib(), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        MyTableView.delegate = self
        MyTableView.dataSource = self
       
        MyTableView.layer.cornerRadius = 20
        MyTableView.clipsToBounds = true
        MyTableView.layer.borderWidth = 5
        MyTableView.layer.borderColor = UIColor.black.cgColor
        //MyTableView.backgroundView = UIImageView(image: UIImage(named: "paper-texture"))
        LogoLabel.font = UIFont(name: font, size: 45)
        
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 40
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 5
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        // 버튼의 leading, top 제약 추가
        button.trailingAnchor.constraint(equalTo: MyTableView.trailingAnchor, constant: -30).isActive = true
        button.bottomAnchor.constraint(equalTo: MyTableView.bottomAnchor, constant: -50).isActive = true
        // 버튼의 너비, 높이 제약 추가
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
        detailsViewController.list = self.list
        self.present(detailsViewController, animated: true, completion: nil)
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
        
        
        cell.Title.font = UIFont(name: font, size: 16.0)
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
            cell.ImportantFlagImageView.image = UIImage(systemName: "star.fill" )
        }else{
            cell.Title.textColor = .black
            cell.ImportantFlagImageView.image = nil
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
        action.backgroundColor = .black
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
        let currentTodo = list[indexPath.row]
        let detailsViewController = DetailsViewController()
        detailsViewController.modalPresentationStyle = .automatic
        detailsViewController.modalTransitionStyle = .coverVertical
        detailsViewController.dataTransferDelegate = self
        detailsViewController.list = self.list
        detailsViewController.currentTodo = currentTodo
        detailsViewController.index = indexPath.row
        self.present(detailsViewController, animated: true, completion: nil)
        print(list[indexPath.row])
    }
}

extension ViewController : DataTransferDelegate {
    func sendData(_ data: [Todo]) {
        print(data)
        self.list = data
        self.MyTableView.reloadData()
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
