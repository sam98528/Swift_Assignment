import UIKit
import Alamofire

class SearchBookViewModel{
    var didGetResult: ((SearchBookViewModel) -> Void)?
    var recentBooks: [Book] = []
    var dataSource: UITableViewDiffableDataSource<Section, SectionItem>?
    var requestResults: BookAPIModel? {
        didSet{
            didGetResult?(self)
        }
    }
    let webService = WebServices()
    var kakaoBookSearch = ApiModel(
        url: "https://dapi.kakao.com/v3/search/book",
        header: ["Authorization" : "KakaoAK 9f7d574ec38f35d53233f50e7bd2a13e"],
        parameter: nil
    )
    
}

extension SearchBookViewModel{
    func getResult(title: String, page : Int){
        kakaoBookSearch.parameter = ["query" : title]
        webService.requestAPI(url: self.kakaoBookSearch.url, expecting: BookAPIModel.self, headers: self.kakaoBookSearch.header, parameters: kakaoBookSearch.parameter){ [self] result in
            switch result{
            case .success(let data):
                requestResults =  self.checkSalePrice(data : data)
                applySnapshot()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func applySnapshot() {
        guard let requestResults else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        snapshot.appendSections([.searchBook])
        
        let items:[SectionItem] = requestResults.books.map({
            .book($0)
        })
        
        snapshot.appendItems(items)
        dataSource?.apply(snapshot,animatingDifferences: false)
    }
    
    private func checkSalePrice(data : BookAPIModel) -> BookAPIModel{
        var data = data
        for (index,book) in data.books.enumerated(){
            if book.salePrice == -1{
                data.books[index].salePrice = book.price
            }
        }
        return data
    }
    
    func bookInIndex(index: Int) -> Book?{
        if let book = requestResults?.books[index] {
            return book
        }else{
            return nil
        }
    }
}
