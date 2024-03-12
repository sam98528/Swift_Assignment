import Foundation
/*
func solution(_ n:Int) -> [Int] {
    var arr :[[Int]] = []
    for i in 1...n {
        arr.append(Array(repeating:0 , count: i))
    }
    
    var x = -1
    var y = 0
    var num = 1
    
    for temp in stride (from : n, through: 1, by : -1){
        print("temp: \(temp)")
        if x < temp {
            for i in 0..<temp{
                x += 1
                arr[x][y] = num
                num += 1
            }
            print(" x < temp, x: \(x), y: \(y)")
            print(arr)
            print("")
            continue
        }
        
        if y < temp {
            for i in 0..<temp{
                y += 1
                arr[x][y] = num
                num += 1
            }
            print("y < temp, x: \(x), y: \(y)")
            print(arr)
            print("")
            continue
        }
        
        if x > temp{
            for i in 0..<temp{
                x -= 1
                y -= 1
                arr[x][y] = num
                num += 1
            }
            print("x > temp, x: \(x), y: \(y)")
            print(arr)
            print("")
            continue
        }
        
        if y > temp {
            for i in 0..<temp{
                arr[x][y] = num
                x -= 1
                y -= 1
                num += 1
            }
            print("y > temp, x: \(x), y: \(y)")
            print(arr)
            print("")
            continue
        }
        
         
    }
    
    return []
}

solution(5)
*/


func solution(_ n:Int) -> [Int] {
    var arr :[[Int]] = []
    for i in 1...n {
        arr.append(Array(repeating:0 , count: i))
    }
    var functionArr : [(Int)->Void] = []
    var x = -1
    var y = 0
    var num = 1
    
    functionArr.append { temp in
            for i in 0..<temp{
                x += 1
                arr[x][y] = num
                num += 1
            }
            print(" x < temp, x: \(x), y: \(y)")
            print(arr)
            print("")
    }
    functionArr.append { temp in
            for i in 0..<temp{
                y += 1
                arr[x][y] = num
                num += 1
            }
            print("y < temp, x: \(x), y: \(y)")
            print(arr)
            print("")
    }
    
    functionArr.append { temp in
        for i in 0..<temp{
            x -= 1
            y -= 1
            arr[x][y] = num
            num += 1
        }
        print("x > temp, x: \(x), y: \(y)")
        print(arr)
        print("")
    }
    
    var order = 0
    for temp in stride (from : n, through: 1, by : -1){
        functionArr[order%3](temp)
        order += 1
    }
    let ans = arr.flatMap{$0}
    return ans
}

print(solution(6))
