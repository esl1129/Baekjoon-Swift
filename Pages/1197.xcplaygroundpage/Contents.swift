import Foundation

struct edge{
    let start: Int
    let end: Int
    let price: Int
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
var edgeArr = [edge]()

for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    edgeArr.append(edge(start: line[0], end: line[1], price: line[2]))
}

var answer = 0
for edge in edgeArr.sorted{$0.price < $1.price}{
    let start = visited[edge.start]
    let end = visited[edge.end]
    let max = start > end ? start : end
    let min = start < end ? start : end
    if start == end { continue }
    answer += edge.price
    if check(max,min) { break }
}
print(answer)
