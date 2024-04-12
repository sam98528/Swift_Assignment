//
//  WishListViewController.swift
//  WishList
//
//  Created by Sam.Lee on 4/12/24.
//

import UIKit
import CoreData

class WishListViewController: UIViewController{
    
    let coreDataManger = CoreDataManger()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wishListTableView: UITableView!
    var data : [WishProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = coreDataManger.getCurrnetData().sorted{$0.id < $1.id}
        titleLabel.text = "My WishList"
        titleLabel.font = UIFont(name: "FuturaCyrillic-Demi", size: 30)
        titleLabel.layer.cornerRadius = titleLabel.layer.bounds.height / 2
        titleLabel.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.borderWidth = 5
        wishListTableView.dataSource = self
        wishListTableView.delegate = self
        wishListTableView.register(WishListTableViewCell.nib(), forCellReuseIdentifier: WishListTableViewCell.identifier)
    }
}

extension WishListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wishListTableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier, for: indexPath) as? WishListTableViewCell else {return UITableViewCell()}
        let currentWish = data[indexPath.row]
        
        cell.titleLabel.text = currentWish.title
        cell.priceLabel.text = "$ \(Int.addCommas(to: Int(currentWish.price)))"
        cell.idLabel.text = "# \(currentWish.id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
