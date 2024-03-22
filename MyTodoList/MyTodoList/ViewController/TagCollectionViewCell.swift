//
//  TagCollectionViewCell.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/20/24.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    let font = "EF_Diary"
    
    @IBOutlet weak var tagLabel: UILabel!
    static let identifier = "TagCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TagCollectionViewCell", bundle: nil)
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
