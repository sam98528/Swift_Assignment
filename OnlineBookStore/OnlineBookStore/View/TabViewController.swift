//
//  ViewController.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/2/24.
//

import UIKit

class TabViewController: UITabBarController {

    
    let tabViewModel = TabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure(){
        self.setViewControllers(tabViewModel.navs, animated: true)
    }

    
}

