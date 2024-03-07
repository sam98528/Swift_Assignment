/*
[240306 Q&A 공유]
1. n차원 배열 순회
a. 모든 요소를 순회하기 위해서 1차원, 2차원, 3차원... 늘어날 때마다 1개, 2개, 3개..의 for-in 순회가 필요 (map 등의 고차함수를 사용해도 마찬가지)
b. 연습: 0~99까지 숫자를 순서대로 10개마다 1개의 배열로 구성한 총 10개의 1차원 배열이 들어있는 2차원 배열에서 3의 배수에 해당하는 요소만 출력해보기
아래 2차원 배열을 직접입력하는 하드코딩 방식 대신 다른 방법으로 생성할 수있는 방법이 있는지도 고민해보기
*/
import Foundation

var numArr : [[Int]] = []
for i in stride(from: 0, to: 100, by: 10){
    var tempArr : [Int] = []
    for j in i..<i+10{
        tempArr.append(j)
    }
    numArr.append(tempArr)
}

let flatArr = numArr.flatMap{$0}
let answer = flatArr.filter{$0 % 3 == 0}
print(answer)
