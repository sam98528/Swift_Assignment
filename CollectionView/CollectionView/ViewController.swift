//
//  ViewController.swift
//  CollectionView
//
//  Created by Sam.Lee on 4/2/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let fontB = "BRR"
    let fontR = "BRR"
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Coffee.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.menuEnglishNameLabel.font = UIFont(name: fontB, size: 12)
        cell.menuNameLabel.font = UIFont(name: fontB, size: 15)
        cell.menuTypeLabel.font = UIFont(name: fontB, size: 12)
        cell.menuTypeLabel.text = "아이스크림"
        cell.priceLabel.font = UIFont(name: fontB, size: 15)
        cell.menuEnglishNameLabel.text = Coffee.data[indexPath.row].englishName
        cell.menuNameLabel.text = Coffee.data[indexPath.row].koreanName
        var image = Coffee.data[indexPath.row].image
        cell.menuImageView.image = Coffee.data[indexPath.row].image
        cell.menuImageView.translatesAutoresizingMaskIntoConstraints = false
        //cropImage(, rightCrop: -200, bottomCrop: -200)
        cell.priceLabel.text = String(Coffee.data[indexPath.row].price)
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.05).cgColor
        cell.layer.borderWidth = 5
        return cell
    }
    
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: Int(collectionView.frame.size.width / 2 - 20) , height: Int(collectionView.frame.size.height / 3) - 20)
        collectionView.collectionViewLayout = flowLayout
        
    }

}

