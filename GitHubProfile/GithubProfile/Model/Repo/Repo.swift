import Foundation

struct Repo : Codable {
    var name: String?
    var language: String?
    var html_url: String?
}

extension Repo {
    static var data : [Repo] = []
}
