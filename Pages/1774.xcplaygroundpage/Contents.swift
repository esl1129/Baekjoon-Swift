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

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]

var visited = [Int](repeating: 0, count: N+1)
for i in 1...N{
    visited[i] = i
}
var arr = [[Double]]()
var edgeArr = [edge]()

for _ in 0..<N{
    arr.append(readLine()!.components(separatedBy: " ").map{Double(String($0))!})
}

for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let start = visited[line[0]]
    let end = visited[line[1]]
    if start == end { continue }
    let max = start > end ? start : end
    let min = start < end ? start : end
    if check(max,min) { break }
}

for i in 0..<N-1{
    for j in i+1..<N{
        if visited[i+1] == visited[j+1] { continue }
        let price = sqrt((arr[i][0]-arr[j][0])*(arr[i][0]-arr[j][0])+(arr[i][1]-arr[j][1])*(arr[i][1]-arr[j][1]))
        edgeArr.append(edge(start: i+1, end: j+1, price: price))
    }
}

var answer = 0.0
for edge in edgeArr.sorted{$0.price < $1.price}{
    let start = visited[edge.start]
    let end = visited[edge.end]
    if start == end { continue }
    let max = start > end ? start : end
    let min = start < end ? start : end
    answer += edge.price
    if check(max,min) { break }
    
}
print(String(format: "%.2f", answer))
