//
//  ViewController.swift
//  TodoList
//
//  Created by Jeong-bok Lee on 3/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addTodoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setBlurView() {
        lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .white.withAlphaComponent(0.8)
            dimmedView.frame = self.view.bounds
            containerView.tag = 100
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            
            return containerView
        }()
        view.addSubview(blurredView)
    }
    
    @IBAction func addTodo(_ sender: Any) {
        setBlurView()
        let alert = CustomAlertViewController()
        alert.modalPresentationStyle = .custom
        alert.delegate = self
        present(alert, animated: true)
        
    }
}

// 추가사항
extension ViewController : BlurVCDelegate {
    func removeBlurView() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    func addNewTodo(text: String){
        
    }
    
    
}
