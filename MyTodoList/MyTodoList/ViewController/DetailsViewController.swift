//
//  DetailsViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/19/24.
//

import UIKit

protocol DataTransferDelegate: AnyObject {
    func finishedEditing()
}
// 태그 수정페이지 Delegate
extension DetailsViewController : TagSettingDelegate {
    func finishedTagSetting(tagList: [Tag]) {
        print("CALLED")
        if currentTodo != nil {
            tempTag = tagList
        }else{
            newTodo.tag = []
            for (_,element) in tagList.enumerated(){
                newTodo.tag.append(element.tagName)
                tempTag = tagList
            }
            
        }
        self.tagCollectionView.reloadData()
    }
}

// 키보드 숨기기
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// 키보드로 인해 화면 가려졌을때 view 위로 올리기
extension DetailsViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if memoTextView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight = keyboardSize.height
                // Adjust your view accordingly, for example:
                let transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = transform
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
}

//TextField Return 키 키보드 내리기
extension DetailsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

//TextView PlaceHolder
extension DetailsViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder{
            textView.text = nil
            textView.textColor = UIColor.label
            textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
            textView.textContainerInset = UIEdgeInsets(top: (textView.bounds.height - textView.contentSize.height) / 2 - 10, left: 0, bottom: 0, right: 0)
        }
    }
    func textFieldShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}

// Tag 보여주기용 CollectionView
// 변경 OR 신규 추가에 따라서 다르게 작동
extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentTodo != nil {
            return tempTag.count
        }else{
            if newTodo.tag.count == 0 {
                return 0
            }else{
                return newTodo.tag.count
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        
        if currentTodo != nil {
            cell.tagLabel.text = tempTag[indexPath.row].tagName
        }else{
            cell.tagLabel.text = newTodo.tag[indexPath.row]
        }
        cell.tagLabel.backgroundColor = tempTag[indexPath.row].color
        cell.tagLabel.font = UIFont(name: font, size: 14)
        cell.tagLabel.layer.cornerRadius = 10
        cell.tagLabel.layer.borderColor = UIColor.black.cgColor
        cell.tagLabel.layer.borderWidth = 1.0
        //cell.tagLabel.backgroundColor = .gray
        cell.tagLabel.clipsToBounds = true
        cell.tagLabel.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var tag : String
        if currentTodo != nil {
            tag = tempTag[indexPath.row].tagName
        }else{
            tag = self.newTodo.tag[indexPath.row]
        }
        let attributes = [NSAttributedString.Key.font: UIFont(name: font, size: 14)]
        
        let tagSize = (tag as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        return CGSize(width: tagSize.width + 20, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentTodo != nil {
            tempTag.remove(at: indexPath.row)
        }else{
            newTodo.tag.remove(at: indexPath.row)
        }
        self.tagCollectionView.deleteItems(at: [indexPath])
        
    }
}


class DetailsViewController: UIViewController {
    let font = "EF_Diary"
    let textViewPlaceHolder = "텍스트를 입력하세요"
    
    weak var dataTransferDelegate : DataTransferDelegate?
    
    var currentTodo : Todo?
    var newTodo = Todo(id: 1, title: "", isCompleted: false, isImportant: false, startDate: nil, endDate: nil, memo: "", tag: [], isOpen: false)
    var tempTag : [Tag] = []
    
    var index : Int?
    var important = false
    
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var importantButton: UIButton!
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    //Tag 수정화면 띄우기
    @IBAction func TagCollectionButtonTouched(_ sender: Any) {
        let tagModifyView = TagSettingViewController()
        if self.currentTodo != nil {
            tagModifyView.currentTags = self.tempTag
        }else{
            tagModifyView.currentTagArray = self.newTodo.tag
        }
        tagModifyView.delegate = self
        self.present(tagModifyView, animated: true)
    }
    //중요함 버튼 처리하기
    @IBAction func importantButtonTouched(_ sender: Any) {
        important = important ? false : true
        if important {
            self.importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            self.importantButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
        
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        // CurrentTodo 가 nil이 아니면 "기존 투두 변경"
        // Nil 이면 신규 추가
        if currentTodo != nil {
            tempTag = []
            for (_,element) in currentTodo!.tag.enumerated(){
                if let temp = Tag.tagDic[element] {
                    tempTag.append(temp)
                }
            }
            print("tempTag.count : \(tempTag.count)")
            titleTextField.text = currentTodo?.title
            titleTextField.textAlignment = .center
            
            startTimeDatePicker.date = (currentTodo?.startDate)!
            endTimeDatePicker.date = (currentTodo?.endDate)!
            
            important = (currentTodo?.isImportant)!
            
            if important {
                self.importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else{
                self.importantButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }else{
            memoTextView.text = textViewPlaceHolder
            memoTextView.textContainerInset = UIEdgeInsets(top: (memoTextView.bounds.height - memoTextView.contentSize.height) / 2 - 10, left: 0, bottom: 0, right: 0)
            memoTextView.textAlignment = .center
            memoTextView.textColor = .lightGray
            tagButton.setImage(UIImage(systemName: "plus"), for: .normal)
            
        }
        
        titleNavigationItem.title = "투두 변경 중.."
        titleNavigationItem.rightBarButtonItem?.title = "저장"
        memoTextView.text = currentTodo?.memo
        memoTextView.textColor = .black
        memoTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        memoTextView.textAlignment = .natural
        
        
        
        memoTextView.delegate = self
        memoTextView.font = UIFont(name: font, size: 15.0)
        memoTextView.layer.borderWidth = 5
        memoTextView.layer.cornerRadius = 20
        memoTextView.layer.borderColor = UIColor.black.cgColor
        
        titleTextField.font = UIFont(name: font, size: 20.0)
        titleTextField.backgroundColor = .clear
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 5
        titleTextField.clipsToBounds = true
        titleTextField.delegate = self
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font, size: 20)!]
        titleNavigationItem.leftBarButtonItem?.action = #selector(self.dismissLeftButton)
        titleNavigationItem.rightBarButtonItem?.action = #selector(self.addRightBUtton)
        titleNavigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        titleNavigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        
        // 테두리 BackgroundView 추가
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.borderWidth = 5
        backgroundView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: memoTextView.topAnchor,constant: -5).isActive = true
        self.view.sendSubviewToBack(backgroundView)
    }
    
    // 상단 취소 버튼
    @objc func dismissLeftButton(){
        self.dismiss(animated: true, completion: nil)
        
    }
    // 상단 추가 / 변경 버튼
    @objc func addRightBUtton(){
        if self.titleTextField.text == ""{
            let alert = UIAlertController(title: "오류", message: "제목을 입력해주세요!", preferredStyle: .alert)
            let close = UIAlertAction(title: "확인", style: .destructive, handler: nil)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }else{
            if currentTodo != nil {
                Todo.list[index!].title = titleTextField.text!
                Todo.list[index!].isImportant = important
                Todo.list[index!].startDate = startTimeDatePicker.date
                Todo.list[index!].endDate = endTimeDatePicker.date
                Todo.list[index!].memo = memoTextView.text
                Todo.list[index!].tag = []
                for (_,element) in tempTag.enumerated(){
                    Todo.list[index!].tag.append(element.tagName)
                    Tag.tagDic.updateValue(element, forKey: element.tagName)
                }
            }else{
                Todo.todoID += 1
                let currentTodoID = Todo.todoID
                newTodo = Todo(id: currentTodoID, title: titleTextField.text!, isCompleted: false, isImportant: important ,startDate: startTimeDatePicker.date, endDate: endTimeDatePicker.date ,memo: memoTextView.text!, tag: newTodo.tag, isOpen: false)
                Todo.list.append(newTodo)
                for (_,element) in tempTag.enumerated(){
                    Tag.tagDic.updateValue(element, forKey: element.tagName)
                }
            }
            self.dataTransferDelegate?.finishedEditing()
            self.dismiss(animated: true, completion: nil)
        }
    }
}


