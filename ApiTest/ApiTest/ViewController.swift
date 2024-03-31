//
//  ViewController.swift
//  ApiTest
//
//  Created by Sam.Lee on 3/29/24.
//

import UIKit

class ViewController: UIViewController{

    var userModel = UserModel()
    var repoModel = RepoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userModel.delegate = self
        userModel.getUser()
        
        repoModel.delegate = self
        repoModel.getRepo()
    }
    
    

}

extension ViewController : UserModelDelegate {
    // MARK: UserModelDelegate Function
    func userRetrieved(user: User) {
        //print(user)
    }
}

extension ViewController : RepoModelDelegate {
    func reposRetrieved(repos: [Repo]) {
        print(repos)
    }
}
