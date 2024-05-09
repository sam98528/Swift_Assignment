import UIKit

class RecentBooksViewModel{
    
    var dataSource: UICollectionViewDiffableDataSource<RecentBookSection, RecentBooksSectionItem>?
    
    var recentBooks: [Book] = []
    var readBook: Book?

    func applySnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<RecentBookSection, RecentBooksSectionItem>()
        snapshot.appendSections([.recentBooks])
        let items:[RecentBooksSectionItem] = recentBooks.map({
            .recentBook($0)
        })
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
