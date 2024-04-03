//
//  ViewController.swift
//  ApiTest
//
//  Created by Sam.Lee on 3/29/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController{
    
    var userModel = UserModel(user: "sam98528")
    var repoModel = RepoModel(user: "apple")
    var idLabel: UILabel!
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var followersLabel: UILabel!
    var followingsLabel: UILabel!
    var profileImageView: UIImageView!
    var repoTableView: UITableView!
    var currentUser: User?
    var token : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userModel.delegate = self
        userModel.getUserAlamofire()
        
        repoModel.delegate = self
        repoModel.getRepoAlamofire()
        
        setView()
    }
    
    
    
}

extension ViewController {
    
    func setView(){
        idLabel = {
            let label = UILabel()
            label.text = "아이디 : "
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        nameLabel = {
            let label = UILabel()
            label.text = "이름 : "
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        locationLabel = {
            let label = UILabel()
            label.text = "지역 : "
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        followersLabel = {
            let label = UILabel()
            label.text = "팔로워 : "
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        followingsLabel = {
            let label = UILabel()
            label.text = "팔로잉 : "
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        profileImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "person.crop.circle")
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            return image
        }()
        let verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillProportionally
            stackView.spacing = 5
            return stackView
        }()
        
        [idLabel!,nameLabel!,locationLabel!,followersLabel!,followingsLabel!].map{
            verticalStackView.addArrangedSubview($0)
        }
        
        
        let mainStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            //stackView.heightAnchor.constraint(lessThanOrEqualToConstant: 150.0).isActive = true
            return stackView
        }()
        
        mainStackView.addArrangedSubview(profileImageView!)
        mainStackView.addArrangedSubview(verticalStackView)
        
        self.view.addSubview(mainStackView)
        
        repoTableView  = {
            let tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: ProfileTableViewCell.identifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false

            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
            return tableView
        }()
        
        self.view.addSubview(mainStackView)
        self.view.addSubview(repoTableView!)

        mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        repoTableView!.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10.0).isActive = true
        repoTableView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        repoTableView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        repoTableView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
    }
    
    @objc func handleRefreshControl(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            self.repoTableView.reloadData()
            self.repoTableView.refreshControl?.endRefreshing()
        }
    }
}

extension ViewController : UserModelDelegate , RepoModelDelegate {
    // MARK: UserModelDelegate, RepoModelDelegate Function
    func userRetrieved(user: User) {
        idLabel.text = "아이디 : \(user.login ?? "오류")"
        nameLabel.text = "이름 : \(user.name ?? "오류")"
        locationLabel.text = "지역 이름 : \(user.location ?? "없음")"
        followersLabel.text = "팔로워 수 : \(String(user.followers ?? 0))"
        followingsLabel.text = "팔로잉 수 : \(String(user.following ?? 0))"
        let processor = RoundCornerImageProcessor(cornerRadius: profileImageView.layer.bounds.width)
        if let profileImageStr = user.avatar_url{
            profileImageView.kf.indicatorType = .activity
            profileImageView.kf.setImage(with: URL(string: profileImageStr), options: [.processor(processor)])
        }
        self.currentUser = user
    }
    
    func reposRetrieved(repos: [Repo]) {
        repoTableView.reloadData()
    }
    
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Repo.data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        
        cell.languageLabel.text = Repo.data[indexPath.row].language
        cell.repoNameLabel.text = Repo.data[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == Repo.data.count {
            
            self.repoModel.getRepoAlamofire()
        }
    }
    
    
}
