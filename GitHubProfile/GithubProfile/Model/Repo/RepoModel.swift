import Foundation
import Alamofire


protocol RepoModelDelegate {
    func reposRetrieved(repos : [Repo])
}

class RepoModel {
    
    var delegate: RepoModelDelegate?
    var urlString = "https://api.github.com/users/"
    let user : String
    var token : String = ""
    var page = 1
    var lastPage = Int.max
    var checkedLastPage = false
    
    init(delegate: RepoModelDelegate? = nil, user: String, urlString: String = "https://api.github.com/users/") {
        self.delegate = delegate
        self.user = user
        self.urlString = urlString + self.user + "/repos"
        do {
            self.token = try Configuration.value(for: "API_TOKEN")
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getRepoURLSession() {
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("URL ERROR")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {(data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let repos = try decoder.decode([Repo].self, from: data!)
                    Repo.data = repos
                    DispatchQueue.main.async {
                        self.delegate?.reposRetrieved(repos: repos)
                    }
                }catch {
                    print("Error Parsing Json")
                }
            }
        }
        dataTask.resume()
    }
    
    func getRepoAlamofire() {
        // 페이지 번호를 적용하여 URL 생성
        if page < lastPage {
            let url = URL(string: "\(urlString)?page=\(page)")!
            var headers: HTTPHeaders?
            if token != "" {
                headers = ["Authorization": token]
            }
            AF.request(url,headers: headers).response { response in
                if !self.checkedLastPage {
                    if let headers = response.response?.headers {
                        if let linkHeader = headers["Link"] {
                            let links = linkHeader.components(separatedBy: ",")
                            for link in links {
                                if link.contains("rel=\"last\"") {
                                    if let pageRange = link.range(of: "page=")?.upperBound {
                                        let nextPageIndex = link[pageRange...]
                                            .prefix(while: { $0.isNumber })
                                        if let pageNumber = Int(nextPageIndex) {
                                            print(pageNumber)
                                            self.lastPage = pageNumber
                                            self.checkedLastPage = true
                                            break
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                switch response.result {
                case .success(let data):
                    do {
                        let newRepos = try JSONDecoder().decode([Repo].self, from: data!)
                        Repo.data.append(contentsOf: newRepos) // 새로운 데이터를 기존 데이터에 추가
                        
                        DispatchQueue.main.async {
                            self.delegate?.reposRetrieved(repos: newRepos)
                        }
                        
                        // 다음 페이지로 이동
                        self.page += 1
                    } catch {
                        print("Error Parsing Json")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
