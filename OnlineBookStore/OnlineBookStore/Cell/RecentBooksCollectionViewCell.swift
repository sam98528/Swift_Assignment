//
//  RecentBooksCollectionViewCell.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/8/24.
//

import UIKit
import SnapKit
import Kingfisher

class RecentBooksCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentBooksCollectionViewCell"
    let image = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        [image,titleLabel].forEach{
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        image.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(80)
        }
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(image.snp.bottom).inset(-5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(book: Book){
        self.configureUI()
        image.kf.setImage(with: URL(string: book.thumbnail), placeholder: UIImage(systemName: "x.circle"))
        titleLabel.text = book.title
    }
}
