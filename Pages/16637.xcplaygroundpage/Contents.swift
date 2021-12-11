import Foundation

let N = Int(readLine()!)!
let arr = readLine()!.map{String($0)}

func operate(_ arr:[String]) -> Int{
    var newArr = arr
    while newArr.count > 3{
        newArr = [String(sum(Array(newArr[0..<3])))]+Array(newArr[3..<newArr.count])
    }
    return sum(newArr)
}
func sum(_ arr: [String]) -> Int{
    var sum = 0
    switch arr[1]{
    case "+":
        sum = Int(arr[0])!+Int(arr[2])!
    case "-":
        sum = Int(arr[0])!-Int(arr[2])!
    case "*":
        sum = Int(arr[0])!*Int(arr[2])!
    default:
        break
    }
    return sum
}
func find(_ arr: [String], _ index: Int) -> Int{
    if arr.count == 1{
        return Int(arr[0])!
    }
    var max = operate(arr)
    if arr.count < index+1 {
        return max
    }
    for i in stride(from: index, to: arr.count, by: 2){
        let prefix = i == 1 ? [] : Array(arr[0..<i-1])
        let suffix = i == arr.count-2 ? [] : Array(arr[i+2..<arr.count])
        let now = find(prefix+[String(sum(Array(arr[i-1...i+1])))]+suffix, i+2)
        max = max > now ? max : now
    }
    return max
}

print(find(arr,1))
