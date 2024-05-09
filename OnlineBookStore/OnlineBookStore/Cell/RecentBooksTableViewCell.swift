//
//  RecentBooksTableViewCell.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/8/24.
//

import UIKit
import SnapKit
import Kingfisher

protocol RecentBookTouchDelegate{
    func redirectToDetailView(detailVC: UIViewController)
}
class RecentBooksTableViewCell: UITableViewCell {

    static var identifier = "RecentBooksTableViewCell"
    var delegate : RecentBookTouchDelegate?
    private var viewModel = RecentBooksViewModel()
    var collectionView : UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder : NSCoder){
        fatalError("init(Coder:) has not been implemented")
    }

    override func prepareForReuse() {
        configureDiffableDataSource()
    }
    func configure(recentBooks: [Book]){
        viewModel.recentBooks = recentBooks
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView = {
            flowLayout.itemSize = CGSize(width: 80, height: 150)
            let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
            cv.delegate = self
            cv.register(RecentBooksCollectionViewCell.self, forCellWithReuseIdentifier: RecentBooksCollectionViewCell.identifier)
            cv.bouncesHorizontally = true
            cv.showsHorizontalScrollIndicator = false
            return cv
        }() 
        configureUI()
        configureDiffableDataSource()
        viewModel.applySnapshot()
    }
    
    func configureUI(){
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
            make.bottom.equalToSuperview().priority(999)
        }
    }
    
    func configureDiffableDataSource(){
        self.viewModel.dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .recentBook(let recentBooks):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBooksCollectionViewCell.identifier, for: indexPath) as? RecentBooksCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.configure(book: recentBooks)
                return cell
            }
        })
    }
}

extension RecentBooksTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .recentBook(let book):
            let detailVC = DetailViewController()
            let detailVM = DetailViewModel()
            detailVM.currentBook = book
            detailVC.viewModel = detailVM
            self.delegate?.redirectToDetailView(detailVC: detailVC)
            
        }
    }
}
