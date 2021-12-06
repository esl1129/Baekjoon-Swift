import Foundation

let N = Int(readLine()!)!
let numbers = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let operators = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
var max = -Int.max
var min = Int.max
func operation(_ numbers: [Int], _ operators: [Int]){
    if numbers.count == 1{
        let now = numbers.reduce(0, +)
        max = max > now ? max : now
        min = min < now ? min : now
        return
    }
    
    for (index,oper) in operators.enumerated(){
        if oper <= 0 { continue }
        var newOperators = operators
        newOperators[index] -= 1
        var num = 0
        switch index{
        case 0:
            num = numbers[0]+numbers[1]
        case 1:
            num = numbers[0]-numbers[1]
        case 2:
            num = numbers[0]*numbers[1]
        case 3:
            num = numbers[0]/numbers[1]
        default:
            break
        }
        operation([num]+Array(numbers[2..<numbers.count]),newOperators)
    }
    return
}
operation(numbers, operators)
print(max)
print(min)

