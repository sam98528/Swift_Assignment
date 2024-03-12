### 내배캠 3주차 과제 
---
### 숫자 야구 만들기 (Commnad Line Tools)
- 이번 과제는 숫자 야구 게임을 만드는 것이다. 랜덤으로 중복되지 않는 3개의 숫자를 생성하여, 사용자가 입력한 숫자의 대한 피드백을 주는 것이다.
- 예를 들어 `358` 이라는 숫자가 랜덤으로 생성이 되었고, 사용자가 `598`를 입력한다고 가정하면 
    - 5는 정답에 포함이 되어 있지만, 제대로 된 자리가 아니기 때문에 [ 1 볼 ].
    - 9는 정담에 포함되어 있지 않기 때문에 패스.
    - 8는 정확한 자리에 있기 때문에 [ 1 스트라이크 ]
    - 최종적으로 `1 스트라이크, 1 볼` 을 출력 한다.
- 사용자가 정답을 맞힐 경우에는 메인 화면으로 돌아간다.
- 추가적으로 메인 화면에서는 `1. 게임진행`, `2. 기록보기`, `3.종료하기`. 3가지의 메뉴가 있으며, `2. 기록보기` 를 선택시에는 지금까지 진행한 게임들의 기록을 보여준다. `3. 종료하기`를 선택시에는 모든 기록들을 삭제하고 프로그램을 종료한다. 
---
- 나의 접근 방식은 클래스를 생성해서, 모든 과정을 클래스에서 진행했다. 
- 총 8개의 메서드를 생성했고, 각각 어떤 기능을 수행하는지의 대해 설명하려고 한다. 

~~~swift
class Game {
    
    fileprivate var answer : [Int] = []
    fileprivate var attempts: [Int] = []
    
    deinit {
        print("<숫자 야구 게임을 종료합니다>")
    }
    
    // Game Launch 함수
    // 게임 메인 화면 표시 및 다른 메뉴로 이동 관련 함수
    func launch (){
       ...
    }
    // 실제 게임 스타트 함수
    func startGame () {
        ...
    }
    
    // 기록 보여주기 함수
    func showAttempts(){
        ...
    }
    
    // 랜덤 숫자 만들기 함수
    func generateAnswer(){
        ...
    }
    
    // 입력값이 정확한 입력값이 확인하는 함수
    func isCorrectString (_ input: String) -> Bool {
        ...
    }
    
    // 정답인지 확인하는 함수
    func checkAnswer(_ input : String) -> Bool{
        ...
    }
}
~~~
- 우선 Game 클래스는 8개의 메서드와 2개의 프로퍼티로 구성이 되어 있다. 두개의 프로퍼티를 fileprivate로 선언한 이유는 해당 프로그램에서는 크게 의미가 없지만, 실제로는 외부에서 접근하여 변경을 하면 안되는 코드라고 생각해서 사용했다.
- `fileprivate var answer : [Int] = []` 는 변수 이름을 통해 알 수 있듯이, 랜덤으로 생성된 3개의 정수를 담은 정수 배열이다. 어쩌피 각 자리별로 비교를 해야하고, 순서가 중요하기 때문에, 하나의 정수 혹은 하나의 문자열로 저장하지 않고, 배열로 저장하였다. 
- `fileprivate var attempts: [Int] = []` 는 시도 횟수를 저장하는 정수 배열이다. 기록을 보기 위해서 매 게임이 진행되는 동안 시도 횟수를 저장하고, 게임이 종료된 시점 (정답을 맞힌 시점에서) 해당 배열에 추가하여 저장한다. 
- ` deinit {
        print("<숫자 야구 게임을 종료합니다>")
    }`은 해당 클래스를 갖은 인스턴스를 Deinitialization 을 위해 있는 소멸자이다. 사실 해당 프로그램에서는 하나의 인스턴스만 생성하고, 해당 인스턴스의 메서드를 통해 프로그램 종료를 할 수 있지만. 배운 내용을 활용하여, 프로그램 종료전에 인스턴스를 소멸하여 메모리영역에서 삭제하는 과정도 추가하였다. 
---
- 이제 각 메서드의 대한 설명이다. 

### Launch()
~~~ swift
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
                }
                else{
                    print("옮바른 숫자를 입력해주세요")
                    print("")
                }
            }
        }
    }
~~~
- 이 함수는 게임 시작화면을 보여주고, 선택지의 따라서 다른 메서드를 호출하는 메서드이다.
- 처음에는 `init()`을 사용하여, 인스턴스가 생성되는 시점에서 자동으로 호출을 할까 고민을 했었지만, 이번 과제는 물론 게임을 시작하고 종료하는것까지가 목표지만, 추가적으로 해당 클래스를 다른 곳에서 같이 사용할 경우에는 인스턴스를 생성하는 시점에서, 초기화하는 시점에서 하는것은 효율적이지 않다고 생각하여 `launch()` 함수를 만들었다. 
- 복잡한 메서드는 아니다, `while`문 안에 `print` 문을 실행하고, `if let str = readline()`을 통해 사용자의 input을 받고, 만약 input의 길이가 1이 아닌 경우 오류문을 print하고, 다시 처음화면인 메뉴선택을 화면을 보여준다. 
- `if let option = Int(str)`을 통해서 사용자가 입력한 한 글자가 숫자인지 확인하고, 만약 숫자가 맞다면, if let 괄호 안으로 들어가서, 옵션의 따른 메서드를 호출한다. 숫자가 아니라면 오류문을 print 하고 다시 원래 선택화면으로 돌아간다.
---

### GenerateAnswer()
~~~swift
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
~~~
- 이 메서드는 사용자가 선택화면에서 1번을 고를경우 먼저 호출되는 메서드다. 
- 이 메서드는 랜덤으로 중복되지 않는 3자리 숫자를 생성하고, 프로퍼티인 answer에 저장한다.
- 사용한 방법은 randomElement()를 통해 0부터 9까지 있는 배열에서 랜덤으로 하나의 숫자를 선택한다. 다만 첫번째 숫자가 0인 경우에는 다시 뽑는다. 이 부분이 이 코드의 개선해야할 점이라고 생각한다. 이론상 랜덤이지만, 0이 계속 나올수도 있기 때문에, 시간적으로 불안정한 부분이다.
- 만약 0이 아닌 숫자를 뽑았을 경우, 해당 숫자를 `answer.append(number)`를 통해 추가하고, 해당 숫자를 0부터 9까지 있는 배열에서 삭제해서 중복을 방지한다. 
---
### StartGame()
~~~swift
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
~~~
- 이 메서드는 실제로 게임이 진행되는 메서드다. 
- 사용자가 정답을 맞출때까지 계속 진행이 되며, 이건 `correct` 변수로 확인한다. 
- 사용자가 입력값이 정확한 숫자인지 확인하기 위해 `isCorrectString(str : String) -> Bool` 메서드를 호출하여 확인한다. 
- 만약 입력값이 오류가 없다면, 다시 입력값을 `checkAnswer(str: String) -> Bool`에서 정답인지 확인하는 과정을 진행한다. 
- 그리고 정단인지 확인하는 과정할때마다 `attempt`에 1을 추가하여 기록한다. 
- 만약 정답인 경우에는 `attempt`를`attempt[]`에 저장하고 해당 메서드를 종료한다. 
---
### IsCorrectString(_ Input: String) -> Bool
~~~swift
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
~~~
- 이 메서드는 사용자가 정답을 입력한 값이 숫자이고 3자리인지 확인하는 메서드다.
- 우선 `input.count`를 통해 3이 아니라면 `false`를 반환하고, 오류문을 출력한다. 
- 사용자의 입력값의 길이가 3이라면, 해당 입력값이 숫자로만 구성이 되어있는지도 확인을 한다. `for`문을 돌면서, 각각의 `char.isNumber`로 확인한다. 만약 숫자가 아니라면 `false`를 반환하고, 문제가 없다면 `true`를 반환하면서 메서드가 종료된다. 
---
### CheckAnswer(_ Input : String) -> Bool 
~~~swift
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
~~~
- 이 메서드는 사용자가 오류없이 입력한 값을 정답인지 확인하는 메서드다.
- 주어진 입력값을 순회하면서, 각자리 별로 만약에 정답과 일치하다면, `strike += 1`, 자리는 일치하지 않고, `answer.contains(tempNum)`, 즉 존재한다면 `ball += 1`을 한다. 
- 만약 모든 자리를 다 정확하게 맞힌 경우, 즉 `strike`가 3인 경우에는 , `true`를 반환한다.
- 아닌 경우에는 각 상황별로 출력을 하고, `false`를 반환한다.
---
### ShowAttempts()
~~~swift
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
~~~
- 이 메서드는 기록을 보여주는 메서드다.
- 크게 복잡한것은 없고, 만약 기록이 없는 경우, 즉 `Attepmts`를 접근하는 경우에는 게임 기록이 없다는 문구를 출력한다. 있을 경우에는 순회하면서 출력하여 보여준다. 
---
### Deinit()
~~~swift
deinit {
        print("<숫자 야구 게임을 종료합니다>")
 }
~~~
- 마지막으로 `deinit()` 소멸자 함수로 해당 인스턴스가 nil이 되는 경우, 즉 소멸되는 경우에 게임 종료문을 출력한다.
---
### 실행
~~~swift
var firstGame : Game? = Game()
firstGame!.launch()
firstGame = nil
~~~
- 우선 옵셔널 Game 타입으로 인스턴스를 생성하고, 인스턴의 `launch()` 메서드를 호출하고, 해당 메서드가 종료되었다면, 인스턴스를 nil로 바꾸고, `deinit()` 함수가 호출되게끔 설정하였다. 
---
### 출력 화면 

![](https://velog.velcdn.com/images/sam98528/post/9e23b113-0774-4883-9132-e3de025ca5e6/image.png)

![](https://velog.velcdn.com/images/sam98528/post/67c4189a-d658-4789-bdef-e030169f8805/image.png)

![](https://velog.velcdn.com/images/sam98528/post/a7992349-2045-49a0-9975-14cdc9321bc4/image.png)

![](blob:https://velog.io/6407dc89-33fb-4920-9981-e285b71434f9)

![](https://velog.velcdn.com/images/sam98528/post/6a84485d-f894-4b9a-8364-4f4d19000523/image.png)

![](blob:https://velog.io/e7b8c6df-970c-4b2a-b0f0-58498a17dfef)
