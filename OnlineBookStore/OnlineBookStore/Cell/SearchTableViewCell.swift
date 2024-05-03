//
//  SearchTableViewCell.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/2/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    static var identifier = "SearchTableViewCell"
    
    let image = UIImageView()
    let titleLabel = UILabel()
    let author = UILabel()
    let price = UILabel()
    let salePrice = UILabel()
    let publisher = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder : NSCoder){
        fatalError("init(Coder:) has not been implemented")
    }

    func configure(book: Book){
        [image,titleLabel,author,price,salePrice,publisher].forEach{
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        image.contentMode = .scaleAspectFit
        image.kf.setImage(with: URL(string: book.thumbnail),placeholder: UIImage(systemName: "x.circle"))
        image.layer.cornerRadius = 5
        image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        [titleLabel,salePrice].forEach{
            $0.font = UIFont.boldSystemFont(ofSize: 15)
            $0.textColor = .label
        }
        [author,price,publisher].forEach{
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .secondaryLabel
        }
        [salePrice,price].forEach{
            $0.textAlignment = .right
        }
        
        titleLabel.text = book.title
        author.text = book.authors.first
        price.text = Int.addCommas(to: book.price) + " 원"
        price.attributedText = price.text?.strikeThrough()
        salePrice.text = Int.addCommas(to: book.salePrice) + " 원"
        publisher.text = book.publisher

        image.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5).priority(999)
            make.leading.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(image.snp.height).multipliedBy(0.7)
            
        }
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(image.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        author.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(image.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        publisher.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(5)
            make.leading.equalTo(image.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        salePrice.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(image.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        price.snp.makeConstraints { make in
            make.bottom.equalTo(salePrice.snp.top).offset(-5)
            make.leading.equalTo(image.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
    }
}
