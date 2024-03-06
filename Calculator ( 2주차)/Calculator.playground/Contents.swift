// LV1
// ------------------------------------------------------------
/*
 class Calculator {
     func calculate(op : String, firstNumber: Double, secondNumber : Double) -> Double{
         if op == "+"{
             return Double(firstNumber + secondNumber)
         }else if op == "-"{
             return Double(firstNumber - secondNumber)
         }else if op == "*"{
             return Double(firstNumber * secondNumber)
         }else if op == "/"{
             return Double(firstNumber) / Double(secondNumber)
         }
            
         return 0
     }
     
     
 }
 let calculator = Calculator()
 let addResult = calculator.calculate(op: "+", firstNumber: 10, secondNumber: 5)
 let subtractResult = calculator.calculate(op: "-", firstNumber: 10, secondNumber: 5)
 let multiplyResult = calculator.calculate(op: "*", firstNumber: 10, secondNumber: 5)
 let divideResult = calculator.calculate(op: "/", firstNumber: 10, secondNumber: 3)
 
 */


// LV2
// ------------------------------------------------------------
/*
 class Calculator {
     func calculate(op : String, firstNumber: Double, secondNumber : Double) -> Double{
         if op == "+"{
             return Double(firstNumber + secondNumber)
         }else if op == "-"{
             return Double(firstNumber - secondNumber)
         }else if op == "*"{
             return Double(firstNumber * secondNumber)
         }else if op == "/"{
             return Double(firstNumber) / Double(secondNumber)
         }else if op == "%"{
             return firstNumber.truncatingRemainder(dividingBy: secondNumber)
         }
            
         return 0
     }
     
     
 }
 let calculator = Calculator()
 let addResult = calculator.calculate(op: "+", firstNumber: 10, secondNumber: 5)
 let subtractResult = calculator.calculate(op: "-", firstNumber: 10, secondNumber: 5)
 let multiplyResult = calculator.calculate(op: "*", firstNumber: 10, secondNumber: 5)
 let divideResult = calculator.calculate(op: "/", firstNumber: 10, secondNumber: 3)
 let remainResult = calculator.calculate(op: "%", firstNumber: 10, secondNumber: 2.3)
 */



/* LV3
// ------------------------------------------------------------
 
class Calculator {
    var firstNumber : Double
    var secondNumber : Double
    
    init(firstNumber: Double, secondNumber: Double) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
    }
    
    func calculate (op : String) -> Double{
        
        switch op {
        case "+":
            let add = AddOperation()
            return add.operate(self.firstNumber, self.secondNumber)
        case "-":
            let add = SubtractOperation()
            return add.operate(self.firstNumber, self.secondNumber)
        case "*":
            let add = MultiplyOperation()
            return add.operate(self.firstNumber, self.secondNumber)
        case "/":
            let add = DivideOperation()
            return add.operate(self.firstNumber, self.secondNumber)
        default:
            return 0
        }
        
    }
    
}


class AddOperation {
    func operate(_ firstNumber: Double, _ secondNumber: Double ) -> Double {
        return Double(firstNumber + secondNumber)
    }
}

class SubtractOperation {
    func operate(_ firstNumber: Double, _ secondNumber: Double ) -> Double {
        return Double(firstNumber - secondNumber)
    }
}

class MultiplyOperation {
    func operate(_ firstNumber: Double, _ secondNumber: Double ) -> Double {
        return Double(firstNumber * secondNumber)
    }
}

class DivideOperation {
    func operate(_ firstNumber: Double, _ secondNumber: Double ) -> Double {
        return Double(firstNumber / secondNumber)
    }
}

let calculator = Calculator(firstNumber: 10, secondNumber: 10)
let addResult = calculator.calculate(op: "+")
let subtractResult = calculator.calculate(op: "-")
let multiplyResult = calculator.calculate(op: "*")
let divideResult = calculator.calculate(op: "/")

 */

// LV4
// ------------------------------------------------------------

protocol AbstractOperation {
    func operate (_ firstNumber: Double, _ secondNumber: Double ) -> Double
}

class Calculator {
    var firstNumber : Double
    var secondNumber : Double
    
    init(firstNumber: Double, secondNumber: Double) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
    }
    
    func calculate (op : String) -> Double{
        var operation : AbstractOperation
        switch op {
        case "+":
            operation = AddOperation()
        case "-":
            operation = SubtractOperation()
        case "*":
            operation = MultiplyOperation()
        case "/":
            operation = DivideOperation()
        default:
            return 0
        }
        return operation.operate(self.firstNumber, self.secondNumber)
        
    }
    
}


class AddOperation : AbstractOperation {
    func operate(_ firstNumber: Double, _ secondNumber: Double) -> Double{
        return Double(firstNumber + secondNumber)
    }
}

class SubtractOperation : AbstractOperation{
    func operate(_ firstNumber: Double, _ secondNumber: Double) -> Double{
        return Double(firstNumber - secondNumber)
    }
}

class MultiplyOperation : AbstractOperation{
    func operate(_ firstNumber: Double, _ secondNumber: Double ) -> Double {
        return Double(firstNumber * secondNumber)
    }
}

class DivideOperation : AbstractOperation {
    func operate(_ firstNumber: Double, _ secondNumber: Double ) -> Double {
        return Double(firstNumber / secondNumber)
    }
}

let calculator = Calculator(firstNumber: 10, secondNumber: 10)
let addResult = calculator.calculate(op: "+")
let subtractResult = calculator.calculate(op: "-")
let multiplyResult = calculator.calculate(op: "*")
let divideResult = calculator.calculate(op: "/")
