//
//  WishListTableViewCell.swift
//  WishList
//
//  Created by Sam.Lee on 4/12/24.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    static let identifier = "WishListTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WishListTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
