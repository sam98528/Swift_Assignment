# OnlineBookStore
![Static Badge](https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white)
---
## 설명 :

카카오 책 검색 API를 사용해서 책 검색 및 책 담기 기능을 구현했습니다. 해당 프로젝트는 MVVM 사용, Differable Datasource 사용, Code로 UI 구현을 위주로 진행했습니다. 

---
## 실제 작동화면  
|![screenshot1](https://github.com/sam98528/Swift_Assignment/assets/12388297/dcdbcce5-2d26-46af-a66f-73eafaa71ef1) | ![screenshot2](https://github.com/sam98528/Swift_Assignment/assets/12388297/ecc5d53c-12af-4fcf-a8ad-9ec16382256e) | ![screenshot3](https://github.com/sam98528/Swift_Assignment/assets/12388297/920317ba-8d06-41d7-9104-684ea770ecc9) |
|---|---|---|
---

### MVVM 정의
![스크린샷 2024-05-09 12 59 36](https://github.com/sam98528/Swift_Assignment/assets/12388297/02f13d68-050d-4e29-bcf0-aced85172fac)
### 기타 파일 정의
![스크린샷 2024-05-09 13 09 32](https://github.com/sam98528/Swift_Assignment/assets/12388297/ec87bcb6-0e17-4332-9568-aaa0960d89f4)
### FlowChart
![스크린샷 2024-05-09 13 36 43](https://github.com/sam98528/Swift_Assignment/assets/12388297/8ae6ce96-d220-4fcc-b39b-e27414b2f23d)

---
### 개발 기능 정리:
#### 사용한 API, 라이브러리, SDK, 프레임워크 등
- [카카오 책 검색 API](https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide#search-book)
- [Kingfisher](https://github.com/onevcat/Kingfisher) (7.11.0)
- [SnapKit](https://github.com/SnapKit/SnapKit) (5.7.1)
- [Alamofire](https://github.com/Alamofire/Alamofire) (5.9.1)
- [CoreData](https://developer.apple.com/documentation/coredata/)
---

### 겪었던 문제점 및 소감 :
#### MVVM 사용
- MVVM 아키텍처를 처음 사용해서 프로젝트를 진행을 했습니다. 기존에는 MVC에 더 가깝게 구현을 했지만, 이번 프로젝트는 MVVM을 무조건 지키는 방향으로 진행했습니다. 
- 처음에는 간단한 데이터를 받아와서 화면에 그리는거 조차, ViewModel에서 Model에서 데이터를 받아와서, 다시 View로 넘겨주는 것의 대한 어려움 및 의문이 있었습니다. MVVM의 장점을 체험하기에는 어려웠습니다. 하지만 기능이 조금씩 계속 추가 되면서, 정확히 어떤 부분에서 오류가 발생하고, 어느 부분을 수정해야하는지 MVVM을 사용함으로서 명확하게 분리가 되어서 이렇게 작은 프로젝트를 하면서도 약간의 편리함을 느꼈습니다. 
- 예를 들면, 화면에서 TableView를 보여줘야할떄, 데이터가 잘못됐다면, 바로 ViewModel을 보면되고, 그리는 문제가 생겼다면 View만 보면 된다는 장점이 있다는것은 확실하게 알게 되었습니다. 다시 말해, MVVM에서 추구하는 각각의 역할 및 책임이 명확하게 분리가 되어 있다면, 추후에 더욱 더 큰 프로젝트에서는 그 효과가 더욱 더 크게 보여질꺼라고 느꼈습니다. 
- 다만 제가 직접 경험해본 MVVM의 불편했던점도 있었습니다. 간단히 예시를 들면, View에서 다른 View로 데이터를 넘겨주고 Present를 해야하는 경우에는, 결국 View를 Present를 하기위해서는 ViewController에서 진행을 해야하는데, 데이터를 넘겨주는 부분은 어떻게 보면 ViewModel의 역할인것 같기도 하고, 그렇다고 데이터를 넘겨주기 위해 ViewModel에 해당 데이터를 저장하고, 다시 불러오는 방식이 효율적인지는 솔직하게 잘 모르겠다는 생각을 했습니다. 
- 그리고 이번에 Differable Datasource를 사용해서 TableView를 Section을 두개를 나눠서, 하나는 일반적인 TableViewCell을 보여주고, 하나는 TableViewCell안에 또 CollectionView가 있는걸로 구현을 했습니다. 물론 처음부터 CollectionView의 Compositional Layout를 사용했다면 문제가 없었다고 생각을 하지만, 저는 일단 Tableview로 구현을 했습니다. 문제는 TableViewCell안에 있는 CollectionView DataSource는 그러면 어디에서 담당을 해야하는지의 대한 어려움이 있었습니다. 제가 이해한 바로는 Cell이 ViewModel을 갖는다는것은 MVVM에서는 흔히 있는 일은 아니라고 생각했는데, ViewModel 없이 Cell 자체에서 DataSource까지 관리를 하는것은 또 그거 나름대로 MVVM의 맞지 않지 않나 라는 생각을 했습니다. 결국 ViewModel을 만들어서 DataSource를 담당했지만, 해당 부분이 솔직히 완벽하게 했다고 생각하지 않습니다. 추후에는 Compositional Layout를 사용해서 DataSource를 하나의 ViewModel에서 관리하는 방향으로 구현을 해야곘다고 생각을 했습니다.
- MVVM을 사용하며서 또 어려웠던 점은 데이터 전달하는 방식이었습니다. 기존에는 Delegate 패턴을 주로 사용했으며, 어떤 액션이 끝나면 Delegat를 이용해서 데이터를 전달하고 했었습니다. MVVM에서도 Delegate패턴을 사용하지만, 제가 느끼기엔 만약에 데이터를 전달해야하는 Depth가 깊어지면 Delegate 패턴을 활용하면 오히려 코드가 더 복잡해진다는 느낌을 받았습니다. 예를 들면, A ViewModel에서 데이터를 받으면, A view로 B View를 present하고, 다시 B ViewModel로 데이터를 전달을 해야한다면, A ViewModel에서 A View로 데이터를 전달하는건 하드코딩으로 한다고 한들, Depth가 깊어지는건 사실이라고 느꼈습니다. 그래서 사용한게 NotificationCenter 였습니다.

#### NotificationCenter 사용
- NotificationCenter는 Swift에서 제공하는 Class로, 특정 이벤트를 Broadcast를 하고, 이를 관찰하고 데이터를 받아오는 Observer가 있는 개념으로 알고 있습니다. 데이터 종류로는 Object도 전달할 수 있고, NotificationKey를 사용해서 Dictionary처럼 데이터를 보낼수 있는걸로 알고 활용했습니다.
- 처음에 NotifcationCenter를 사용했을때는, 정말 좋은 기능이라고 생각을 했습니다. 전혀 관계가 없는 두 객체간에서도 소통을 이렇게 간편하게 할 수 있고, Observer만 잘 설정을 하면, 자동으로 데이터를 받고 처리를 할 수 있다는것에 신기했습니다. 
- 그러다가 문득 그러면 현업에서 해당기능을 많이 사용할까의 대한 의문이 들어서, 튜터님과 대화를 해봤습니다. 결론적으로 당연히 사용하는 기술이지만, 큰 프로젝트에서는 NotificationCenter를 사용하게 되면 역추적하기 어렵다는 단점이 있다고 말씀해주셨습니다. 물론 broadcase할때 마다 Notification.name을 활용해서 어떤 기능을 BroadCast하고 Observe하고 있는지 알수 있는지만, 만약에 정말 많은 broadcast와 observer가 존재한다면, M:N 관계를 갖게 된다면, 그걸 일일이 역 추적하는것은 쉽지 않다고 하셨습니다. 지금 당장 이번 프로젝트에서는 기능이 몇개가 없지만, 기능이 꾸준히 추가되고 변경되는 현업 프로젝트에서는 어느정도의 한계점이 있다는걸 알게 되었습니다. 
- 저 또한 처음에는 NotificationCenter를 사용할때는 전혀 문제가 없었지만, 어느 순간 제가 코드를 찾고 있는 걸 발견했습니다. "내가 어디서 해당 Notificataion을 Broadcast하고 있었지, 어디서 받고 있었지" 이런 생각을 하고 나서, NotificationCenter를 큰 프로젝트에서 활용하기 위해서는 따로 또 BroadCast와 Observer를 정리를 해야되겠구나 라는 생각을 하게 되었고, 그게 어쩌면 NotificationCenter의 약점이 아닐까 라는 생각을 하게 되었습니다. 
- 물론 앱 외부에서 알림을 받을때는 실제로 NotificationCenter를 사용을 하지만, 이외에 단순 데이터 전달용으로 사용할떄에는 조금 더 깊이 생각을 해봐야겠다는 생각을 갖게 되었습니다. 
~~~swift
extension Notification.Name {
    static let bookAdd = Notification.Name("bookAdd")
    static let bookDelete = Notification.Name("bookDelete")
    static let bookRead = Notification.Name("bookRead")
}

// DetailViewModel
func readBook(){
    NotificationCenter.default.post(name: Notification.Name.bookRead, object: currentBook)
}

//SearchViewModel
init(){
        NotificationCenter.default.addObserver(self, selector: #selector(bookRead(notification:)), name: Notification.Name.bookRead, object: readBook)
}
    

~~~
#### Differable DataSource
- Differable DataSource도 이번에 처음 사용해본 기술이었습니다. 기존에는 UITableViewDataSource 프로토콜을 채택해서, 각각의 IndexPath 를 설정해서, 데이터 개수도 파악하고 해야했지만, Differable Datasource를 사용하면 비교적 쉽게 데이터를 TableView에서 추가 삭제를 할 수 있게 되었습니다. 
- 우선 해당 기능은 따지자면 이번 프로젝트에서는 꼭 필요한 기술은 아니었습니다. Section이 추가될수 있는 과제도 아니었고, 정해진 Section만 보여주면 되는 거였지만, 배우는 단계에서 최대한 많은 기술을 체험을 해보고, 추후에는 어느 기술이 어느 시점에서 적합한지 판단할 수 있는 능력을 키우는게 우선이라고 생각했습니다. 
- MVVM 아키텍처에 맞게 설계하기 위해서, DataSource는 ViewModel에서 갖고 있고, DataSource를 수정 변경하느건 View에서 진행을 했고, SnapShot을 Apply 하는건 ViewModel에서 하도록 구현했습니다. 아무래도 DataSource에서는 실제 TableView에 그려지는 부분을 담당하고 있기 때문에 View에서 구현했습니다. 
- 기존에 사용하던 방식이랑 크게 다르지 않았지만, 처음에는 일절 공부를 안하고 ApplySnapShot이 그냥 reloadData()와 같은 역할을 하는구나 정도로만 알고 사용을 했지만, 실제로 공부를 조금 해보니 약간의 차이점이 있다는걸 알게 되었습니다. 기존에 Reloaddata는 말그대로 data를 새로 불러와서, 달라진 부분이 없더라도 전체적인 data를 reload를 하는 반면에, ApplySnapShot은 달라진 부분만 변경하기 때문에, 효율적일 수 밖에 없습니다. 물론 내부적으로 어떤 알고리즘을 사용해서 비교를 했는지는 모르지만, 전체를 다 변경하지 않는 이상 ApplySnapShot이 더 효율적일 수 밖에 없습니다. 
- 사용방법도 되게 간단했습니다. Section과 sectionItem을 Enum으로 선언하고, SectionItem은 Hashable 프로토콜을 채용해야 합니다, 그 이유는 아마도 비교를 하기 위해서 인걸로 알고 있습니다. 그리고 SnapShot에 Section추가 해주고, Section에 ListSectionItem을 하나씩 추가해주고, 마지막으로 Apply만 해주면 끝!
~~~swift
//ListViewModel
class ListViewModel{
    var dataSource: UITableViewDiffableDataSource<ListViewSection, ListViewSectionItem>?
    '''
func applySnapshot() {
        self.savedBook = CoredataManager.shared.getBooks()
        guard let savedBook else { return }
        var snapshot = NSDiffableDataSourceSnapshot<ListViewSection, ListViewSectionItem>()
        snapshot.appendSections([.savedBook])
        
        let items:[ListViewSectionItem] = savedBook.map({
            .book($0)
        })
        
        snapshot.appendItems(items)
        dataSource?.apply(snapshot,animatingDifferences: true)
    }

// ListViewController
 func tableViewConfigure(){
        tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
        configureDiffableDataSource()
    }
    
func configureDiffableDataSource() {
    self.viewModel.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
        switch item {
        case .book(let book):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else{
                return UITableViewCell()
            }
            cell.configure(book: book.typeCasting())
            cell.selectionStyle = .none
            return cell
        }
    })
}

 override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()
        viewModel.applySnapshot()
    }

~~~

#### TableView Delegate 사용
- TableView DataSource는 Differable DataSource를 사용했지만, Delegate는 기존에 사용하던 방식 그대로 사용했습니다. 튜터님 세션에서는 원래는 RxSwift를 주로 사용하신다고 하셨지만, RxSwift을 아직 써본적이 없기 때문에 기존에 Delegate를 이용해서 터치이벤트, HeaderView,FooterView를 구현했습니다.
- HeaderView를 추가하기 위해서 Section별로 다른 HeaderView를 만들어야하지만, 여기서 문제가 TableViewDelegate Protocol에서 제공되는 함수는 기본적으로 Section을 매개변수로 받고 있습니다. 즉 Section이 Int값으로 설정이 되어 있습니다. 하지만 Differable Datasource는 Section을 Int가 아닌 enum으로 전달을 하고 있습니다. 물론 지금 제가 하는 프로젝트에서는 0번째 Section은 어떤 정보가 있는지 다 알지만, enum을 매칭하는 걸 직접 하는 방법 이외에 다른 방법이 있는지 튜터님께 여쭤봤지만, 지금 현재 상황에서는 Differable Datasource에서 선언한 Section이랑 TableviewDelegate protocol에서 제공하는 section이랑 매칭을 해주는 방식이 제일 효율적일꺼라는 답을 받아서, 그렇게 구현을 했습니다.
- FooterView도 마찬가지로 1번째 Section에서만 보여지게끔 사용하고, UIActivityIndicatorVIew를 사용해서 스크롤를 하면 로딩하는 화면을 FooterView에 추가하였습니다. 그리고 ViewModel과 소통을 해서, 만약에 API 호출이 더이상 안된다면, FooterView를 Nil로 바꿔서 더이상 ActivityIndicator를 보여지지 않게끔 설정했습니다. 
~~~swift
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as? SectionHeaderView else{
            return UIView()
        }
        header.configure(section: section)
        return header
    }
func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if viewModel.requestResults?.meta.isEnd == false && section == 1{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        footerView = view
        return footerView
    }
    else if viewModel.requestResults?.meta.isEnd == true && section == 1{
        footerView = nil
    }
    return nil
}
func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if section == 1 && viewModel.requestResults?.meta.isEnd == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewModel.getMoreResult()
            }
        }
    }
~~~

### 전체적인 소감
- 이번 프로젝트를 하면서 아직 모르는 기술이 정말 많다는 생각을 하게 되었습니다. 같은 걸 구현하더라도, 정말 많은 다양한 방법이 존재하고, 스타일이 다르고, 장단점도 있다는것을 깨닫게 되었습니다. 튜터님이 말씀해신 내용중에서 이런 내용이 되게 인상적이었습니다. "면접을 보고, 포트폴리오를 제출할때는, 정확하게 왜 어떤 기술을 사용했는지의 대해 다 설명할 수 있어야 한다". 많은 기술들을 사용해보는것은 정말 좋지만, 왜 사용하고, 장단점을 파악을 하고 적합하게 사용하는것이 좋은 개발자라는 말씀이신것 같다. 
- 추후에 하는 프로젝트에서는 더 많은 기술들을 공부해보고, 사용해보고, 그중에서 적합한 걸 선택하고 그 이유의 대해 설명하는 연습을 해보는것도 좋겠다는 생각을 했습니다. 
