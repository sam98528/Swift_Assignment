import Foundation

class Game {
    fileprivate var answer : [Int] = []
    
    func generateAnswer(){
        var numbers = [1,2,3,4,5,6,7,8,9,0]
        var ans : [Int] = []
        for _ in 1...3 {
            if let number = numbers.randomElement() {
                ans.append(number)
                numbers.remove(at: numbers.firstIndex(of: number)!)
            }else {
                print("ERROR")
            }
        }
        answer = ans
    }
    
    func startGame () {
        print("<게임을 시작합니다>")
        print(answer)
        var correct = false
        while(!correct){
            print("숫자를 입력하세요!")
            if let str = readLine(){
                if !isCorrectString(str) {
                    continue
                }else {
                    correct = checkAnswer(str)
                }
            }
            
            
            print("")
        }
    }
    
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


let firstGame = Game()
firstGame.generateAnswer()
firstGame.startGame()
