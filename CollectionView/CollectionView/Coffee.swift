import Foundation
import UIKit


struct Coffee {
    // 커피 종류 한국어
    var koreanName: String
    // 커피 종류 영어
    var englishName: String
    // 가격
    var price : Int
    // 이미지
    var image : UIImage
}

extension Coffee {
    
    static var data : [Coffee] = [
        Coffee(koreanName: "아이스아메리카노", englishName: "Americano Iced", price: 3900, image: UIImage(named: "Mint Chocolate Chip")!),
        Coffee(koreanName: "아포카토 라떼", englishName: "Affogato Latte", price: 4500, image: UIImage(named: "Rainbow Sherbet")!),
        Coffee(koreanName: "아이스 카페 라떼", englishName: "Cafe Latte Iced", price: 7500, image: UIImage(named: "Lychee Berry Iced Tea")!)
    ]
}
