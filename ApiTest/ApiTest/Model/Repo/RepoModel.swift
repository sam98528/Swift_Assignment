import Foundation

protocol RepoModelDelegate {
    func reposRetrieved(repos : [Repo])
}
class RepoModel {
    
    var delegate: RepoModelDelegate?
    let user = "sam98528"

    func getRepoURLSession() {
        var urlString = "https://api.github.com/users/"
        urlString += user + "/repos"
        
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
    
    
}
