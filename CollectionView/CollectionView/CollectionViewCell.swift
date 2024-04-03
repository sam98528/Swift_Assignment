//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Sam.Lee on 4/2/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuEnglishNameLabel: UILabel!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var menuTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuImageView.layoutMargins = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        // Initialization code
    }
    static let identifier = "CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
