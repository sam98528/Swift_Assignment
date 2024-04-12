import Foundation

struct Repo : Codable {
    let name: String
    let language: String?
    let htmlUrl: String
    
    enum CodingKeys : String, CodingKey {
        case name
        case language
        case htmlUrl = "html_url"
    }
}

extension Repo {
    static var data : [Repo] = []
}
