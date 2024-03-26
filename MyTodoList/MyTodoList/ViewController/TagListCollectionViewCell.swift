//
//  TagListCollectionViewCell.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/22/24.
//

import UIKit



class TagListCollectionViewCell: UICollectionViewCell {
    
    var index : Int = 0
    var currentColor : UIColor = .clear
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var viewList: UIView!

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
        //delButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 1)
        // Initialization code
        
    }

    override var isSelected: Bool {
        didSet{
            if oldValue == false{
                self.tagLabel.backgroundColor = currentColor
            }else{
                self.tagLabel.backgroundColor = currentColor
            }
            
        }
    }
}
