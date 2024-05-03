import Foundation
import Alamofire


struct BookAPIModel : Codable, Hashable{
    let meta: Meta
    var books : [Book]
    
    enum CodingKeys: String, CodingKey{
        case meta
        case books = "documents"
    }
}

struct Meta : Codable,Hashable {
    let totalCount: Int
    let pageableCount: Int
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey{
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}

struct Book : Codable,Hashable{
    let title: String
    let contents: String
    let url: String
    let authors: [String]
    let publisher: String
    let price: Int
    var salePrice: Int
    let thumbnail: String
    let status: String
    
    enum CodingKeys: String, CodingKey{
        case title,contents,url,authors,publisher,price,thumbnail,status
        case salePrice = "sale_price"
    }
}


