//
//  ViewController.swift
//  ApiTest
//
//  Created by Sam.Lee on 3/29/24.
//

import UIKit

class ViewController: UIViewController{

    var userModel = UserModel(user: "sam98528")
    var repoModel = RepoModel(user: "sam98528")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userModel.delegate = self
        //userModel.getUserURLSession()
        //userModel.getUserAlamofire()

        repoModel.delegate = self
        repoModel.getRepoAlamofire()
    }
    
    

}

extension ViewController : UserModelDelegate {
    // MARK: UserModelDelegate Function
    func userRetrieved(user: User) {
        print(user)
    }
}

extension ViewController : RepoModelDelegate {
    func reposRetrieved(repos: [Repo]) {
        print(repos)
    }
}
