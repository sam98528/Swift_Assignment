//
//  ToDoTableViewCell.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"
    
    @IBOutlet weak var IsCompletedSwitch: UISwitch!
    @IBOutlet weak var Title: UILabel!
    
    @IBAction func IsCompletedSwitchTouched(_ sender: UISwitch) {
        if !sender.isOn{
            self.Title.attributedText = self.Title.text?.strikeThrough()
        }else{
            if let text = self.Title.text {
                    let attributedString = NSMutableAttributedString(string: text)
                    attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
                    self.Title.attributedText = attributedString
                }
        }
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

