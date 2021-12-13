import Foundation

struct edge{
    let start: Int
    let end: Int
    let price: Double
}

func check(_ from: Int, _ to: Int) -> Bool{
    var cnt = 0
    for i in 1...N{
        if visited[i] == from{
            visited[i] = to
        }
        if visited[i] == 1{
            cnt += 1
        }
    }
    
    return cnt == N
}
let N = Int(readLine()!)!

var visited = [Int](repeating: 0, count: N+1)
for i in 1...N{
    visited[i] = i
}
var arr = [[Double]]()
var edgeArr = [edge]()

for _ in 0..<N{
    let now = readLine()!.components(separatedBy: " ").map{Double(String($0))!}
    arr.append(now)
    if arr.count == 1 { continue }
    let size = arr.count
    for i in 1..<arr.count{
        let price = sqrt((now[0]-arr[i-1][0])*(now[0]-arr[i-1][0])+(now[1]-arr[i-1][1])*(now[1]-arr[i-1][1]))
        edgeArr.append(edge(start: i, end: size, price: price))
    }
}
var answer = 0.0
for edge in edgeArr.sorted{$0.price < $1.price}{
    let start = visited[edge.start]
    let end = visited[edge.end]
    let max = start > end ? start : end
    let min = start < end ? start : end
    if start == end { continue }
    answer += edge.price
    if check(max,min) { break }
}
print(String(format: "%.2f", answer))
