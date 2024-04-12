//
//  ViewController.swift
//  UserDefaultsPractice
//
//  Created by Sam.Lee on 4/12/24.
//

import UIKit

class ViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 저장
        defaults.set("TEST",forKey: "key")
        
        // 데이터 조회
        let temp = defaults.value(forKey: "key")
        // Optional <Any>
        print(type(of: temp))
        
        // 옵셔널 바인딩을 사용해서 데이터 조회 후 String 타입으로 변경
        let temp2 = defaults.object(forKey: "key") as? String
        print(temp2 ?? "")
        
        let sam = Person(name: "Sam", age: 25)
        
//        // 바로 구조체 인스턴스를 바로 넣으면
//        defaults.set(sam,forKey: "sam")
//        let sam2 = defaults.object(forKey: "sam") as? Person
//
//        // 오류
//        print(sam2?.name ?? "")
        
        // 사용자 정의 타입 저장하기
        if let encodeData = try? JSONEncoder().encode(sam) {
            defaults.set(encodeData, forKey: "sam")
        }
        
        // 사용자 저장 타입으로 데이터 불러오기
        if let data = defaults.data(forKey: "sam") {
            if let decodedData = try? JSONDecoder().decode(Person.self, from: data) {
                print(decodedData)
            }
        }
        
        // 데이터 삭제하기
        defaults.removeObject(forKey: "key")
        
        // 전체 데이터 조회하기
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
          print("\(key) = \(value) \n")
        }
    }
    

}

struct Person : Codable{
    var name : String
    var age : Int
}
