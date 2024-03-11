import Foundation

let numbers = [1,2,3,4,5,6,7,8,9,0]

// Using randomElement()
func generateRandomElement(_ arr : [Int]) -> [Int]{
    var arr = arr
    var ans : [Int] = []
    for _ in 1...3 {
        if let number = arr.randomElement() {
            ans.append(number)
            arr.remove(at: arr.firstIndex(of: number)!)
        }else {
            print("ERROR")
        }
    }
    return ans
}

// Using Shuffle
func generateShuffle( _ arr: [Int]) -> [Int]{
    var arr = arr.shuffled()
    return arr.suffix(3)
    
}

var answerWithRandomElement = generateRandomElement(numbers)
var answerWithShuffle = generateShuffle(numbers)
print(answerWithRandomElement)
print(answerWithShuffle)

