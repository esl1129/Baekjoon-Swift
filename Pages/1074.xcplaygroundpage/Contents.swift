import Foundation

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let row = line[1]
let col = line[2]

var num = 0
var max = Int(pow(2.0, Double(N)))
var answer = 0
var startX = 0
var startY = 0

func check(_ x: Int, _ y: Int, _ len: Int) -> Int{
    if row >= x && row < x+len/2 && col >= y && col < y+len/2 { return 0 }
    if row >= x && row < x+len/2 && col >= y+len/2 && col < y+len { return 1}
    if row >= x+len/2 && row < x+len && col >= y && col < y+len/2 { return 2}
    return 3
}
while max > 1{
    let cnt = check(startX, startY, max)
    switch cnt{
    case 1:
        startY = startY+max/2
    case 2:
        startX = startX+max/2
    case 3:
        startX = startX+max/2
        startY = startY+max/2
    default:
        break
    }
    max /= 2
    answer += max*max*cnt
}
print(answer)
