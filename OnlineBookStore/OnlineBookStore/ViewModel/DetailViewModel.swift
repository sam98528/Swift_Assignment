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
        return currentBook?.authors.first ?? ""
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
    
    func saveBook(){
        if let bookToSave = currentBook{
            CoredataManager.shared.saveBook(bookToSave: bookToSave)
        }
    }
    func readBook(){
        NotificationCenter.default.post(name: Notification.Name.bookRead, object: currentBook)
    }
}
