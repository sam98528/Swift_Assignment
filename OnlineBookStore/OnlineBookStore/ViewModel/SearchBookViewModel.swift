import UIKit
import Alamofire


class SearchBookViewModel{
    var didGetResult: ((SearchBookViewModel) -> Void)?
    var recentBooks: [Book] = []
    var readBook: Book?
    var recentTouchBook: Book?
    var dataSource: UITableViewDiffableDataSource<SearchViewSection, SearchViewSectionItem>?
    var requestResults: BookAPIModel? {
        didSet{
            didGetResult?(self)
        }
    }
    var page : Int = 1
    let webService = WebServices()
    var kakaoBookSearch = ApiModel(
        url: "https://dapi.kakao.com/v3/search/book",
        header: ["Authorization" : "KakaoAK 9f7d574ec38f35d53233f50e7bd2a13e"],
        parameter: nil
    )
    var didSavedBook : ((SearchBookViewModel, String) -> Void)?
    var savedBookTitle: String?{
        didSet{
            didSavedBook?(self, savedBookTitle ?? "")
        }
    }
    var title : String = ""
    init(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(bookSaved(notification:)), name: Notification.Name.bookAdd, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bookRead(notification:)), name: Notification.Name.bookRead, object: readBook)
    }
    
}

extension SearchBookViewModel{
    func getResult(title: String){
        self.title = title
        kakaoBookSearch.parameter = ["query" : title]
        webService.requestAPI(url: self.kakaoBookSearch.url, expecting: BookAPIModel.self, headers: self.kakaoBookSearch.header, parameters: kakaoBookSearch.parameter){ [self] result in
            switch result{
            case .success(let data):
                requestResults = BookAPIModel(meta: data.meta, books: self.checkSalePrice(data : data))
                applySnapshot()
            case .failure(let error):
                print(error)
            }
        }
    }
    func getMoreResult(){
        guard let isEnd = requestResults?.meta.isEnd else {
            return
        }
        if !isEnd{
            self.page += 1
            kakaoBookSearch.parameter = ["query" : title, "page" : page]
            webService.requestAPI(url: self.kakaoBookSearch.url, expecting: BookAPIModel.self, headers: self.kakaoBookSearch.header, parameters: kakaoBookSearch.parameter){ [self] result in
                switch result{
                case .success(let data):
                    requestResults?.meta = data.meta
                    requestResults?.books.append(contentsOf: self.checkSalePrice(data : data))
                    applySnapshot()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func applySnapshot() {
        guard let requestResults else { return }
        var snapshot = NSDiffableDataSourceSnapshot<SearchViewSection, SearchViewSectionItem>()
        snapshot.appendSections([.recentBook])
        snapshot.appendItems([.recentRead(recentBooks)])
        snapshot.appendSections([.searchBook])
        
        let items:[SearchViewSectionItem] = requestResults.books.map({
            .searchResult($0)
        })
        
        snapshot.appendItems(items)
        
        dataSource?.apply(snapshot,animatingDifferences: false)
    }
    
    private func checkSalePrice(data : BookAPIModel) -> [Book]{
        var data = data
        for (index,book) in data.books.enumerated(){
            if book.salePrice == -1{
                data.books[index].salePrice = book.price
            }
        }
        return data.books
    }
    
    func bookInIndex(index: Int) -> Book?{
        if let book = requestResults?.books[index] {
            return book
        }else{
            return nil
        }
    }
    
    @objc func bookSaved(notification: Notification){
        guard let title = notification.userInfo?[NotificationKey.title] as? String else{
            return
        }
        self.savedBookTitle = title
    }
    
    @objc func bookRead(notification: Notification){
        guard let book = notification.object as? Book else{
            return
        }
        if recentBooks.contains(where: { $0.title == book.title }){
            if let index = recentBooks.firstIndex(where: {$0.title == book.title}){
                recentBooks.remove(at: index)
                recentBooks.insert(book, at: 0)
            }
        }else if recentBooks.count == 5 {
            recentBooks.removeLast()
            recentBooks.insert(book, at: 0)
        }else{
            recentBooks.insert(book, at: 0)
        }
        self.applySnapshot()
    }
    
}



