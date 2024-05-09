import Foundation

enum SearchViewSection : String{
    case recentBook = "최근 본 책"
    case searchBook = "검색 결과"
}

enum SearchViewSectionItem : Hashable{
    case recentRead([Book])
    case searchResult(Book)
}

enum ListViewSection{
    case savedBook
}

enum ListViewSectionItem : Hashable{
    case book(SavedBook)
}

enum RecentBookSection{
    case recentBooks
}

enum RecentBooksSectionItem : Hashable {
    case recentBook(Book)
}


