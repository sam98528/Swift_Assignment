import Foundation
import Alamofire

protocol UserModelDelegate {
    func userRetrieved(user : User)
    
}

class UserModel {
    
    var delegate: UserModelDelegate?
    var urlString = "https://api.github.com/users/"
    var user : String
    var token : String = ""
    
    init(delegate: UserModelDelegate? = nil, user: String, urlString: String = "https://api.github.com/users/") {
        self.delegate = delegate
        self.user = user
        self.urlString = urlString + self.user
        do{
            self.token = try Configuration.value(for: "API_TOKEN")
        }catch{
            print(error.localizedDescription)
        }
    }
    
   
    func getUserURLSession(){
        // Request User
        // Parse JSON into User Instances and pass to viewController
        // Using Protocol and delegate Pattern
        
        // 1. 요청할 URL를 String 저장
        
        // 2. String -> URL 인스턴스
        let url = URL(string: urlString)
        
        // 3. url nil값인지 확인
        guard url != nil else{
            print("URL ERROR")
            return
        }
        
        // 4. URLSession 생성
        let session = URLSession.shared
        // 5. DataTask 생성
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            // 6. 에러체크 및 데이터를 성공적으로 get 했는지 체크
            if error == nil && data != nil {
                // JSON 객체를 swift 인스턴스 객체로 변환하는 Decoder 객체 생성
                let decoder = JSONDecoder()
                do{
                    // 9. try 문을 앞에 붙여서 JSON 데이터를 이전에 만들어준 User swift 인스턴스로 파싱해줍니다.
                    let user = try decoder.decode(User.self, from: data!)
                    DispatchQueue.main.async{
                        self.delegate?.userRetrieved(user: user)
                    }
                }catch {
                    print("Error Parsing Json")
                }
            }
        }
        dataTask.resume()
    }
    
    func getUserAlamofire(){
        let headers: HTTPHeaders = [
                "Authorization": token
            ]
        AF.request(urlString,headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do{
                    let user = try JSONDecoder().decode(User.self, from: data!)
                    DispatchQueue.main.async{
                        self.delegate?.userRetrieved(user: user)
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
