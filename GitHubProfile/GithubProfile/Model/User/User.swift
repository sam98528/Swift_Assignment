import Foundation

struct User: Codable {
    var login: String?
    var name: String?
    var location: String?
    var followers : Int?
    var following : Int?
    var html_url : String?
    var avatar_url : String?
}

