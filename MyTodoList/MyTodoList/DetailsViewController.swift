//
//  DetailsViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/19/24.
//

import UIKit

class DetailsViewController: UIViewController {

    let font = "EF_Diary"
    

    
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
        /*
        let backgroundImage = UIImageView(frame: view.bounds)
        backgroundImage.image = UIImage(named: "paper-texture")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        self.view.insertSubview(backgroundImage, at: 0)
         */
        memoTextView.font = UIFont(name: font, size: 15.0)
        memoTextView.layer.borderWidth = 1.0
        memoTextView.layer.cornerRadius = 20
        memoTextView.layer.borderColor = UIColor.black.cgColor
        memoTextView.textContainerInset = .init(top: 10, left: 5, bottom: 0, right: 0)
        
        titleTextField.font = UIFont(name: font, size: 20.0)
        titleTextField.backgroundColor = .clear
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font, size: 20)!]
        cancelButtonItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        addButtonItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        //titleNavigationItem.title = "Hello"
        // Do any additional setup after loading the view.
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
