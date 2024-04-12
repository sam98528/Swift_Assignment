import Foundation

struct User: Codable {
    let login: String
    let name: String
    let location: String?
    let followers: Int
    let following: Int
    let htmlUrl: String
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case location
        case followers
        case following
        case htmlUrl = "html_url"
        case avatarUrl = "avatar_url"
    }
}

