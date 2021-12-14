import Foundation

struct Point{
    let x1: Int
    let y1: Int
    let x2: Int
    let y2: Int
}
func replace(_ from: Int, _ to: Int){
    for i in 1...N{
        if visited[i] == from{
            visited[i] = to
        }
    }
}
let N = Int(readLine()!)!

var visited = [Int](repeating: 0, count: N+1)
for i in 0...N{
    visited[i] = i
}
var pointArr = [Point]()
for _ in 0..<N{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    pointArr.append(Point(x1: line[0], y1: line[1], x2: line[2], y2: line[3]))
}

for i in 1...N-1{
    for j in i+1...N{
        let p1 = pointArr[i-1]
        let p2 = pointArr[j-1]
        let parent = (p1.x1-p1.x2)*(p2.y1-p2.y2)-(p1.y1-p1.y2)*(p2.x1-p2.x2)

    }
}
