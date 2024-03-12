// LV 6

import Foundation
class Game {
    
    fileprivate var answer : [Int] = []
    fileprivate var attempts: [Int] = []
    
    deinit {
        print("<숫자 야구 게임을 종료합니다>")
    }
    
    // Game Launch 함수
    // 게임 메인 화면 표시 및 다른 메뉴로 이동 관련 함수
    func launch (){
        var end = false
        
        while(!end){
            print("환영합니다! 원하시는 번호를 입력하세요")
            print("1. 게임시작하기")
            print("2. 게임 기록 보기")
            print("3. 종료하기")
            if let str = readLine(){
                if str.count != 1 {
                    print("옮바른 숫자를 입력해주세요")
                    print("")
                    continue
                }
                if let option = Int(str) {
                    switch option{
                    case 1:
                        generateAnswer()
                        startGame()
                    case 2:
                        showAttempts()
                    case 3:
                        end = true
                        print("")
                    default:
                        print("옮바른 숫자를 입력해주세요")
                        print("")
                    }
                }else{
                    print("옮바른 숫자를 입력해주세요")
                    print("")
                }
            }
        }
    }
    // 실제 게임 스타트 함수
    func startGame () {
        var attempt = 0
        print("")
        print("<게임을 시작합니다>")
        var correct = false
        while(!correct){
            print("숫자를 입력하세요!")
            if let str = readLine(){
                if !isCorrectString(str) {
                    continue
                }else {
                    correct = checkAnswer(str)
                    attempt += 1
                }
            }
            
            
            print("")
        }
        attempts.append(attempt)
    }
    
    // 기록 보여주기 함수
    func showAttempts(){
        print("")
        if attempts.isEmpty {
            print("아직 게임 기록이 없습니다!")
        }else{
            print("<게임 기록 보기>")
            for (index,attempt) in attempts.enumerated() {
                print("\(index + 1) 번째 게임 : 시도 횟수 - \(attempt)")
            }
        }
        print("")
        
    }
    
    // 랜덤 숫자 만들기 함수
    func generateAnswer(){
        var numbers = [1,2,3,4,5,6,7,8,9,0]
        var ans : [Int] = []
        while (ans.count < 3){
            if let number = numbers.randomElement() {
                if ans.count == 0 && number == 0 {
                    continue
                }else{
                    ans.append(number)
                    numbers.remove(at: numbers.firstIndex(of: number)!)
                }
            }else {
                print("ERROR")
            }
        }
        
        answer = ans
    }
    
    // 입력값이 정확한 입력값이 확인하는 함수
    func isCorrectString (_ input: String) -> Bool {
        if input.count != 3 {
            print("올바르지 않는 입력값입니다.(3자리 수)")
            print("")
            return false
        }
        
        for char in input {
            if !char.isNumber{
                print("올바르지 않는 입력값입니다.(숫자만 입력가능)")
                print("")
                return false
            }
        }
        return true
    }
    
    // 정답인지 확인하는 함수
    func checkAnswer(_ input : String) -> Bool{
        var strike = 0
        var ball = 0
        
        for (index,char) in input.enumerated() {
            let tempNum = Int(String(char))!
            if answer.firstIndex(of: tempNum) == index {
                strike += 1
            }else if answer.contains(tempNum){
                ball += 1
            }
        }
        if strike == 3 {
            print("정답입니다!")
            return true
        }else{
            if ball == 0 && strike == 0 {
                print("Nothing")
            }else if ball == 0{
                print("\(strike) 스트롸이크!")
            }else if strike == 0 {
                print("\(ball) 뽈!")
            }else{
                print("\(strike) 스트롸이크! \(ball) 뽈! ")
            }
            return false
        }
        
    }
}


var firstGame : Game? = Game()
firstGame!.launch()
firstGame = nil
