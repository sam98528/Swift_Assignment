//
//  ListViewModel.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/7/24.
//

import UIKit

class ListViewModel{
    var dataSource: UITableViewDiffableDataSource<ListViewSection, ListViewSectionItem>?
    var savedBook: [SavedBook]?
    
    init(){
        self.savedBook = CoredataManager.shared.getBooks()
        NotificationCenter.default.addObserver(self, selector: #selector(applySnapshot), name: Notification.Name.bookAdd, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applySnapshot), name: Notification.Name.bookDelete, object: nil)
    }
}

extension ListViewModel{
    @objc func applySnapshot() {
        self.savedBook = CoredataManager.shared.getBooks()
        guard let savedBook else { return }
        var snapshot = NSDiffableDataSourceSnapshot<ListViewSection, ListViewSectionItem>()
        snapshot.appendSections([.savedBook])
        
        let items:[ListViewSectionItem] = savedBook.map({
            .book($0)
        })
        
        snapshot.appendItems(items)
        dataSource?.apply(snapshot,animatingDifferences: true)
    }
    
    func deleteSavedBook(){
        CoredataManager.shared.deleteAllBook()
    }
    func deleteBook(bookToDelete: SavedBook){
        CoredataManager.shared.deleteBook(bookToDelete: bookToDelete)
    }
    var savedBookCount : Int {
        return self.savedBook?.count ?? 0
    }
}
