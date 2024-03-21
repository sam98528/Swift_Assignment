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
   
    
    var list : [Todo] = [Todo(id: 1, title: "👇🏻 투두 눌러서 펼쳐보기!", startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#투두","#펼쳐보기","#iOS"],isOpen : true),
                         Todo(id: 1, title: "✂️ 왼쪽 스와이프로 수정하기!",startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST", tag: ["#수정하기"]),
                         Todo(id: 1, title: "🗑️ 오른쪽 스와이프로 삭제하기!",startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#삭제하기"]),
                         Todo(id: 1, title: "⭐️ 별 표시 눌러서 강조하기!",isImportant: true, startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#별 꾸욱","#강조","#중요!"]),
                         Todo(id: 1, title: "✅ 체크박스 눌러서 완료 표시하기!",isCompleted: true,startDate:Date(),endDate: Date(timeIntervalSinceNow: 300), memo: "TEST" ,tag: ["#체크박스","#완료!"]),
                         Todo(id: 1, title: "➕ 아래 + 버튼 눌러서 새로운 투두 추가하기",startDate:Date(), endDate: Date(timeIntervalSinceNow: 300),memo: "TEST" ,tag: ["#새로운투두","#추가하기"]),
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
    func importantFlagClicked(index: Int) {
        list[index].isImportant = list[index].isImportant ? false : true
        self.MyTableView.reloadData()
    }
    
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
        
        cell.todo = target
    
        if target.isOpen {
            cell.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        }else{
            cell.backgroundColor = .clear
        }
        //cell.backgroundColor = .clear
        
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
            cell.ImportantFlagImageView.image = UIImage(systemName: "star" )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let info = UIContextualAction(style: .destructive, title: "", handler: {(action, view, completionHandler) in
            let currentTodo = self.list[indexPath.row]
            let detailsViewController = DetailsViewController()
            detailsViewController.modalPresentationStyle = .automatic
            detailsViewController.modalTransitionStyle = .coverVertical
            detailsViewController.dataTransferDelegate = self
            detailsViewController.list = self.list
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
            self.list.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            completionHandler(true)
        })
        del.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [del])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if list[indexPath.row].isOpen{
            return 150
        }else{
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isOpen.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        print(list[indexPath.row])
    }
}

extension ViewController : DataTransferDelegate {
    func sendData(_ data: [Todo]) {
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
