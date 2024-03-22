//
//  TagListCollectionViewCell.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/22/24.
//

import UIKit

class TagListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var viewList: UIView!
    @IBOutlet weak var exitButton: UIButton!
    
    let font = "EF_Diary"
    static let identifier = "TagListCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TagListCollectionViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagLabel.text = ""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
