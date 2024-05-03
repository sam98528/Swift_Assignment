import Foundation

enum Section{
//    case recentBook
    case searchBook
}

enum SectionItem : Hashable{
    case book(Book)
}
