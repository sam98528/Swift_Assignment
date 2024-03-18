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
