import Foundation
import Alamofire


protocol RepoModelDelegate {
    func reposRetrieved(repos : [Repo])
}
class RepoModel {
    
    var delegate: RepoModelDelegate?
    var urlString = "https://api.github.com/users/"
    var user : String
    
    init(delegate: RepoModelDelegate? = nil, user: String, urlString: String = "https://api.github.com/users/") {
        self.delegate = delegate
        self.user = user
        self.urlString = urlString + self.user + "/repos"
    }
    
    func getRepoURLSession() {
    
        
        let url = URL(string: urlString)
        
        guard url != nil else{
            print("URL ERROR")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {(data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let repos = try decoder.decode([Repo].self, from: data!)
                    DispatchQueue.main.async{
                        self.delegate?.reposRetrieved(repos: repos)
                    }
                }catch{
                    print("Error Parsing Json")
                }
            }
        }
        dataTask.resume()
    }
    
    func getRepoAlamofire(){
        print(urlString)
        AF.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                do{
                    let repos = try JSONDecoder().decode([Repo].self, from: data!)
                    DispatchQueue.main.async{
                        self.delegate?.reposRetrieved(repos: repos)
                    }
                }catch {
                    print("Error Parsing Json")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
