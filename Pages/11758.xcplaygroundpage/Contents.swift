import Foundation

var p1 = [Double]()
var p2 = [Double]()
var p3 = [Double]()

p1 = readLine()!.components(separatedBy: " ").map{Double(String($0))!}
p2 = readLine()!.components(separatedBy: " ").map{Double(String($0))!}
p3 = readLine()!.components(separatedBy: " ").map{Double(String($0))!}


let x = (p2[1]-p1[1])*(p3[0]-p1[0])
let y = (p3[1]-p1[1])*(p2[0]-p1[0])

var answer = 0
answer = x == y ? 0 : x > y ? -1 : 1
print(answer)
