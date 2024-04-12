//
//  WishListViewController.swift
//  WishList
//
//  Created by Sam.Lee on 4/12/24.
//

import UIKit
import CoreData

protocol WishListDelegate {
    func wishListModified()
}

class WishListViewController: UIViewController{
    
    let coreDataManger = CoreDataManger()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wishListTableView: UITableView!
    var data : [WishProduct] = []
    var delegate : WishListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = coreDataManger.getCurrnetData()
        titleLabel.text = "My WishList"
        titleLabel.font = UIFont(name: "FuturaCyrillic-Demi", size: 30)
        titleLabel.layer.cornerRadius = titleLabel.layer.bounds.height / 2
        titleLabel.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.borderWidth = 5
        wishListTableView.dataSource = self
        wishListTableView.delegate = self
        wishListTableView.register(WishListTableViewCell.nib(), forCellReuseIdentifier: WishListTableViewCell.identifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.wishListModified()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let del = UIContextualAction(style: .destructive, title: "", handler: {(action, view, completionHandler) in
            self.coreDataManger.deleteData(product: self.data[indexPath.row])
            self.data = self.coreDataManger.getCurrnetData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData()
            completionHandler(true)
        })
        del.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [del])
    }
    
}
