//
//  ToDoTableViewCell.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/18/24.
//
protocol TableViewDelegate {
    func buttonIsClicked(index: Int)
    func importantFlagClicked(index : Int)
}


import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var todo : Todo?
    let font = "EF_Diary"
    static let identifier = "TodoTableViewCell"
    var index = 0
    
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
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
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.importantFlagClicked(index: index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        ImportantFlagImageView.isUserInteractionEnabled = true
        ImportantFlagImageView.addGestureRecognizer(tapGesture)
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        //tagCollectionView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        tagLabel.text = "태그 :"
        tagLabel.font = UIFont(name: font, size: 13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// 메인 투두 테이블뷰에서 Tag 보여주는 CollectionView
extension ToDoTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if todo?.tag.count == 0 {
            return 1
        }else{
            return (todo?.tag.count)!
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        if todo?.tag.count == 0 {
            cell.tagLabel.text = "없음"
        }else{
            cell.tagLabel.text = self.todo?.tag[indexPath.row]
        }
        
        if  Tag.tagDic[cell.tagLabel.text!] != nil{
            let tag = Tag.tagDic[cell.tagLabel.text!]!
            cell.tagLabel.backgroundColor = tag.color
        }
        
        cell.tagLabel.font = UIFont(name: font, size: 13)
        //cell.tagLabel.textColor = UIColor.label
        cell.tagLabel.layer.cornerRadius = 10
        cell.tagLabel.layer.borderColor = UIColor.label.cgColor
        cell.tagLabel.layer.borderWidth = 1.0
        cell.tagLabel.clipsToBounds = true
        cell.tagLabel.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
        }

        // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

        // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag : String
        if todo?.tag.count == 0 {
            tag = "없음"
        }else{
            tag = (todo?.tag[indexPath.row])!
        }
        let attributes = [NSAttributedString.Key.font: UIFont(name: font, size: 13)]
        let tagSize = (tag as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        return CGSize(width: tagSize.width + 20, height: 30)
    }
}

