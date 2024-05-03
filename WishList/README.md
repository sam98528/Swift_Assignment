
# WishList
![Static Badge](https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white)

---
## 설명 :

이번 과제는 API를 통해 랜덤상품 정보를 받아오고, 해당 정보를 사용자에게 보여주고, 사용자가 "장바구니"에 담아서 확인할 수 있는 앱을 구현하는것이 목표입니다. URLSession 과 CoreData를 사용해야하는 것이 제한사항이었습니다. 

---
## 실제 작동화면  
|![스크린샷1](https://github.com/sam98528/Swift_Assignment/assets/12388297/edbb8a7a-25d1-4e6c-a3ad-33471f6a6436) | ![스크린샷2](https://github.com/sam98528/Swift_Assignment/assets/12388297/771b5138-6721-4e71-893e-5d3ed4d0ff66) |
|---|---|

---

### MVC 정의
|Model|ViewController|
|---|---|
|Product.swift|ViewController.swift|
|ProductModel.swift|WishListViewController.swift|
|CoreDataManager.swift|WishListTableViewCell.swift|

## 개발 기능 정리:
### 주요 기능 개발
사용한 API 주소 : https://dummyjson.com/products/{ID}

**LV1 :** 
- [x] API로 받아올 데이터 객체를 만듭니다.
- [x] API로 받아온 데이터에 맞게 CoreData 데이터를 모델링합니다.

**LV2 :** 
- [x] 반드시 사용할 것 : URLSession, UIImage, UILabel
- [x] 디자인 및 화면 구성은 반드시 예시대로 하지 않아도 됩니다.
- [x] 다른 상품 보기 버튼 구현
- [x] 버튼을 누르면 랜덤한 “id”를 생성하고 해당 id에 따라 다른 상품을 보여줍니다.

**LV3 :** 
- [x] 반드시 사용할 것 : UIViewController, TableView, Core Data, UIButton
- [x] 위시 리스트 담기 버튼 구현
- [x] 버튼을 누르면 현재 보여주고 있는 상품의 정보를 CoreData에 저장
- [x] 위시 리스트 보기 페이지 구현
- [x] “위시 리스트 보기” 버튼을 누르면 위시 리스트 담기 버튼을 눌렀을 때 CoreData에 저장한 데이터 노출

**LV4 :**  
- [x] 반드시 사용할 것 : UITableView or UIButton
- [x] 목록을 스와이프하여 삭제 버튼을 노출하고 터치하면 삭제 - UITableView의 기능

**LV5 :**  
- [x] 반드시 사용할 것 : UIRefreshControl
- [x] 위시 리스트의 “다른 상품 보기”를 업그레이드 해봅니다.
- [x] 스크롤을 내려 당기면, Refresh Indicator를 노출시킵니다.
- [x] 데이터를 불러오는동안 잠시, Indicator를 고정시킵니다.

### 겪었던 문제점 및 소감 :
- API 사용하는것에는 큰 문제가 없었던 것 같습니다. 처음에는 Alamofire를 사용했는데, 과제 제한사항에 URLSession만 사용해서 구현을 하라는걸 나중에 봐서, 다시 변경을 했습니다. 
- CoreData를 사용하는게 이번이 처음이라서 과제로 사용하기 전에 먼저 연습으로 구현을 계속 해봤습니다. 
    - NSManagedObjectModel, NSManagedObjectContext, NSPersistentStoreCoordinator 그리고 NSPersistentContainer에 대해서 충분히 공부를 하고 진행했습니다. 
- 다른 과제의 대한 피드백이 대체적으로 가독성의 관한 피드백이 많아서, 해당 과제에서는 가능한 가독성과 사용성 면에서 신경을 써서, 모듈화 할 수 있는 코드는 모듈화를 하고, 데이터는 무조건 모델에서만 추가, 변경을 하게끔 하도록 변경했습니다. 
- 추후에는 CoreData 프레임워크가 아닌 다른 데이터베이스를 사용해서 과제를 진행해보면 좋겠다는 생각을 했습니다.  


