import UIKit

class DetailViewModel{
    var currentBook: Book?
}

extension DetailViewModel{
    var title : String? {
        return currentBook?.title
    }
    var image : String? {
        return currentBook?.thumbnail
    }
    var author : String? {
        return currentBook?.authors[0]
    }
    var publisher: String? {
        return currentBook?.publisher
    }
    var price : String? {
        return Int.addCommas(to: currentBook?.price ?? 0) + " 원"
    }
    var salePrice : String? {
        return Int.addCommas(to: currentBook?.salePrice ?? 0) + " 원"
    }
    var content : String?{
        return currentBook?.contents
    }
}
