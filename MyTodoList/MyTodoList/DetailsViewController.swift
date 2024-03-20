//
//  DetailsViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/19/24.
//

import UIKit

protocol DataTransferDelegate: AnyObject {
    func sendData(_ data: [Todo])
}


class DetailsViewController: UIViewController {

    let font = "EF_Diary"
    
    let textViewPlaceHolder = "텍스트를 입력하세요"
    
    var isEnabled = false
    
    weak var dataTransferDelegate : DataTransferDelegate?
    
    var currentTodo : Todo?
    var index : Int?
    
    var list : [Todo] = []
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
    
    
    let currentCalendar = Calendar.current
    let currentTimeZone = TimeZone.current
    
    var important = false
    
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
        
        if currentTodo != nil {
            
            titleTextField.text = currentTodo?.title
            titleTextField.isEnabled = isEnabled
            titleTextField.textAlignment = .center
            
            startTimeDatePicker.date = (currentTodo?.startDate)!
            startTimeDatePicker.isEnabled = isEnabled
            endTimeDatePicker.date = (currentTodo?.endDate)!
            endTimeDatePicker.isEnabled = isEnabled
            
            important = (currentTodo?.isImportant)!
            if important {
                self.importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else{
                self.importantButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
            
            importantButton.isEnabled = isEnabled
            titleNavigationItem.title = "투두 상세페이지"
            if isEnabled{
                titleNavigationItem.rightBarButtonItem?.title = "저장"
                memoTextView.text = currentTodo?.memo
                memoTextView.textColor = .black
                memoTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
                memoTextView.textAlignment = .natural
            }else{
                memoTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
                memoTextView.textAlignment = .center
                memoTextView.text = currentTodo?.memo
                memoTextView.textColor = .black
                titleNavigationItem.rightBarButtonItem?.title = "변경"
            }
            memoTextView.isEditable = isEnabled
            
            //memoTextView.textAlignment = .natural
            //memoTextView.textContainerInset = .init(top: 10, left: 5, bottom: 0, right: 0)
        }else{
            isEnabled = true
            memoTextView.text = textViewPlaceHolder
            memoTextView.textContainerInset = UIEdgeInsets(top: (memoTextView.bounds.height - memoTextView.contentSize.height) / 2 - 10, left: 0, bottom: 0, right: 0)
            memoTextView.textAlignment = .center
            memoTextView.textColor = .lightGray
            memoTextView.delegate = self
        }
        
        memoTextView.font = UIFont(name: font, size: 15.0)
        memoTextView.layer.borderWidth = 5
        memoTextView.layer.cornerRadius = 20
        memoTextView.layer.borderColor = UIColor.black.cgColor
        
        //memoTextView.textInputView.backgroundColor = .red
        
        
        titleTextField.font = UIFont(name: font, size: 20.0)
        titleTextField.backgroundColor = .clear
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 5
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font, size: 20)!]
        titleNavigationItem.leftBarButtonItem?.action = #selector(self.dismissLeftButton)
        titleNavigationItem.rightBarButtonItem?.action = #selector(self.addRightBUtton)
        titleNavigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        titleNavigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        
        
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.borderWidth = 5
        backgroundView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(backgroundView)

        // safe area를 고려하여 오토레이아웃 설정
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: memoTextView.topAnchor,constant: -5).isActive = true
        self.view.sendSubviewToBack(backgroundView)
        
        
        //titleNavigationItem.title = "Hello"
        // Do any additional setup after loading the view.
    }

    
    @objc func dismissLeftButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addRightBUtton(){
        
        if isEnabled{
            if self.titleTextField.text == ""{
                let alert = UIAlertController(title: "오류", message: "제목을 입력해주세요!", preferredStyle: .alert)
                let close = UIAlertAction(title: "확인", style: .destructive, handler: nil)
                alert.addAction(close)
                present(alert, animated: true, completion: nil)
            }else{
                let startDate = startTimeDatePicker.date
                let endDate = endTimeDatePicker.date
                
                let startConvertedDate = currentCalendar.date(byAdding: .second, value: currentTimeZone.secondsFromGMT(), to: startDate)
                
                let endConvertedDate = currentCalendar.date(byAdding: .second, value: currentTimeZone.secondsFromGMT(), to: endDate)
                
                if currentTodo != nil {
                    list[index!].title = titleTextField.text!
                    list[index!].isImportant = important
                    list[index!].startDate = startConvertedDate!
                    list[index!].endDate = endConvertedDate!
                    list[index!].memo = memoTextView.text
                }else{
                    list.append(Todo(id: 1, title: titleTextField.text!, isCompleted: false, isImportant: important ,startDate: startConvertedDate!, endDate: endConvertedDate! ,memo: memoTextView.text!))
                }
                
                
                self.dataTransferDelegate?.sendData(list)
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            print("Changed")
            isEnabled.toggle()
            viewDidLoad()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension DetailsViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder{
            textView.text = nil
            textView.textColor = .black
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
}
