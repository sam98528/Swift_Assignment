//
//  ToDoTableViewCell.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//
protocol TableViewDelegate {
    func buttonIsClicked(index: Int)
    
}


import UIKit

class ToDoTableViewCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"
    var index = 0
    @IBOutlet weak var ImportantFlagImageView: UIImageView!
    @IBOutlet weak var CheckBoxButton: UIButton!
    @IBOutlet weak var Title: UILabel!
    
    
    var delegate : TableViewDelegate?
    
    @IBAction func CheckBoxButtonClicked(_ sender: UIButton) {
        self.delegate?.buttonIsClicked(index: index)
    }
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let text = Title.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
            Title.attributedText = attributedString
        }
        CheckBoxButton.setImage(UIImage(named: "square"), for: .normal)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TodoTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

