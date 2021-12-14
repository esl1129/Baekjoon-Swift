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

let N = Int(readLine()!)!

var visited = [Int](repeating: 0, count: N+1)
for i in 1...N{
    visited[i] = i
}
var arr = [[Int]]()
var edgeArr = [edge]()

for _ in 0..<N{
    let now = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    arr.append(now)
    if arr.count == 1 { continue }
    let size = arr.count
    for i in 1..<arr.count{
        let price = [abs(now[0]-arr[i-1][0]),abs(now[1]-arr[i-1][1]),abs(now[2]-arr[i-1][2])].min()!
        edgeArr.append(edge(start: i, end: size, price: price))
    }
}

var answer = 0
for edge in edgeArr.sorted{$0.price < $1.price}{
    let start = visited[edge.start]
    let end = visited[edge.end]
    if start == end { continue }
    let max = start > end ? start : end
    let min = start < end ? start : end
    answer += edge.price
    if check(max,min) { break }
}
print(answer)
