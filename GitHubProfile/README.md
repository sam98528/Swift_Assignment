# GithubProfile (iOS)
![Static Badge](https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white)

---
### 개요
**GithubProfile** Swift 프로젝트는 Github Api를 호출해서 사용자 데이터를 받아서 보여주는 프로젝트입니다. 
사용자 프로필 이미지, 아이디, 이름, 지역, 팔로워 수, 팔로잉 수, Repository 리스트를 출력합니다.
MainView의 대한 디자인은 Code로 작성하였으며, tableViewCell의 대한 디자인만 xib 형식으로 구현했습니다. 

---
### 화면 구성
![screenShot](https://github.com/sam98528/Swift_Assignment/assets/12388297/c722f619-1064-4e4b-9e03-e29c216e3502)

---
#### 사용한 UIComponent
- UIStackView (Horizontal, Vertical)
- UITableView
    - UITableViewCell
- UIImageView
- UILabel
---
### 다운로드 방법 (해당 프로젝트만 Clone OR 전체 디렉토리 Clone)
```sh
git init
git remote add origin https://github.com/sam98528/Swift_Assignment.git
git config core.sparsecheckout true
echo 'GithubProfile/*' >> .git/info/sparse-checkout
git pull origin main
```
---
### 초기 세팅 (Config.xcconfig 파일 생성)
API Token 사용을 위해서 Xcode에서 Config.xcconfig 파일 생성 필요합니다. 
Github 에는 Token을 push 할수 없기 때문에, .gitignore을 이용해서 Config.xcconfig파일을 제외했습니다. 
(Github API 호출 시 Authorization 미설정 시 시간당 최대 60회 요청, 설정시 최대 5000회 요청 가능)
- 생성 후 API_TOKEN = Github Token 을 작성해주세요.

---
### 사용 방법
ViewController.swift 파일에서 user 이름 및 Repo 이름을 입력하세요
```swift
var userModel = UserModel(user: "sam98528") // Profile를 로드할 user
var repoModel = RepoModel(user: "Apple") // Repository를 로드할 Organization
```
입력후 실행하면 사용자의 정보 및 repository의 대한 리스트가 보여지게 됩니다. 

---
### 사용한 API
[Github API - Get a User](https://docs.github.com/ko/rest/users/users?apiVersion=2022-11-28#get-a-user)
[Github API - List organization repositories](https://docs.github.com/ko/rest/repos/repos?apiVersion=2022-11-28#list-organization-repositories)
---
### 사용한 Open Source Library
1. [Alamofire](https://github.com/Alamofire/Alamofire) (5.9.1)
    - URLSession 대신 REST API 호출용으로 사용 
    - 사용 예시 코드 (UserModel.swift)
    ```swift
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
    ```
2. [KingFisher](https://github.com/onevcat/Kingfisher) (7.11.0)
    - 프로필 이미지 로드 및 설정용으로 사용 
    - 사용 예시 코드 (ViewController.swift)
    ```swift
        func userRetrieved(user: User) {
            ...
            let processor = RoundCornerImageProcessor(cornerRadius: profileImageView.layer.bounds.width)
            if let profileImageStr = user.avatar_url{
                profileImageView.kf.indicatorType = .activity
                profileImageView.kf.setImage(with: URL(string: profileImageStr), options: [.processor(processor)])
            }
            self.currentUser = user
        }
    ```
---

### Model (Json Decoder 사용위해 snake Case 사용)
1. **User**
    ```swift
    struct User: Codable {
        var login: String? // 사용자 아이디
        var name: String? // 사용자 이름
        var location: String? // 사용자 지역
        var followers : Int? // 팔로워 수 
        var following : Int? // 팔로잉 수
        var html_url : String? // 사용자 페이지 URL
        var avatar_url : String? // 프로필 이미지 URL
    }
    ```
2. **Repo**
    ```swift
    struct Repo : Codable {
        var name: String?  // Repository 이름 
        var language: String? // Repository 사용 언어
        var html_url: String? // Repository URL 
    }
    ```
---
### TableView
1. **Pull to Refresh**
    - TableView 상단에서 아래로 스크롤 할시 새로고침 기능을 구현했습니다. 
    - UITableView 상위 클래스 인 UIScrollView에서는 UIRefreshControl 인스턴스를 사용할 수 있게 구현되어 있습니다. 
    ```swift
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    
    @objc func handleRefreshControl(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            self.repoTableView.reloadData()
            self.repoTableView.refreshControl?.endRefreshing()
        }
    }
    ```
2. **Paging 처리**
    - Github Repository Rest API는 Default로 한 Page당 30개의 result를 반환한다. (최대 100까지 가능)
    - 따라서 TableView에서는 30개 단위로 보여주고, 30개 이상이 필요한 경우에는 추가적으로 API 호출을 하는 방식으로 했습니다. 
     ```swift
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row + 1 == Repo.data.count {
                self.repoModel.getRepoAlamofire()
            }
        }
     ```
     - 마지막 TableViewcell에 도달했을때 API호출 함수를 호출합니다. 다만, API 호출 함수에서 마지막 페이지 인지 확인을 하고, 마지막 페이지인 경우에는 추가적인 API호출을 하지 않습니다. 
