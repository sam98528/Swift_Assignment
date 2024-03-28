//
//  CustomAlertViewController.swift
//  TodoList
//
//  Created by Sam.Lee on 3/27/24.
//

import UIKit

protocol BlurVCDelegate: AnyObject {
    func removeBlurView()
    func addNewTodo(text: String)
}


class CustomAlertViewController: UIViewController {

   
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    var delegate : BlurVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 40
        alertView.layer.borderWidth = 1
        alertView.clipsToBounds = true
        confirmButton.layer.cornerRadius = 25
        cancelButton.layer.cornerRadius = 25
        textField.backgroundColor = UIColor.clear
        
        mainLabel.sizeToFit()
        self.view.backgroundColor = UIColor.clear
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss(_:)))
        tapView.addGestureRecognizer(tapToDismiss)
        tapView.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

    @objc func tapToDismiss(_ recognizer: UITapGestureRecognizer) {
        self.delegate?.removeBlurView()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.delegate?.removeBlurView()
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.delegate?.removeBlurView()
        self.dismiss(animated: true)
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

