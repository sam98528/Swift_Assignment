//
//  ViewController.swift
//  WishList
//
//  Created by Sam.Lee on 4/9/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var productModel = ProductModel()
    var product : Product?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var showCartButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        productModel.getProductsURLSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        productModel.delegate = self
        productModel.getProductsURLSession()
    }
    
}

extension ViewController : ProductModelDelegate {
    func dataRetrieved(product : Product) {
        self.product = product
        self.productDescriptionTextView.text = product.description
        self.productNameLabel.text = product.title
        self.productImageView.kf.indicatorType = .activity
        self.productImageView.kf.setImage(with: URL(string: product.thumbnail))
        self.priceLabel.text = "$\(product.price)"
    }
}

extension ViewController{
    func configure(){
        cartButton.backgroundColor = UIColor.systemGreen
        cartButton.setTitle("위시 리스트 담기", for: .normal)
        
        nextButton.backgroundColor = UIColor.systemRed
        nextButton.setTitle("다른 상품 보기", for: .normal)
        
        showCartButton.backgroundColor = UIColor.systemGray
        showCartButton.setTitle("위시 리스트 보기", for: .normal)
        
        [nextButton, cartButton, showCartButton].forEach { button in
            button.layer.cornerRadius = button.layer.bounds.height / 2
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        }
        productNameLabel.font = UIFont(name: "PeaceSans", size: 25)
        priceLabel.font = UIFont(name: "FuturaCyrillic-Demi", size: 30)
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshNewItem), for: .valueChanged)
    }
    
    @objc func refreshNewItem() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.productModel.getProductsURLSession()
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
}
