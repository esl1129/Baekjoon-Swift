import Foundation


let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]

var visited = [Int](repeating: 0, count: N+1)
for i in 1...N{
    visited[i] = i
}

var roads = [[Int]]()
for _ in 0..<M{
    roads.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var answer = 0
for road in roads.sorted{$0[2] < $1[2]} {
    let start = road[0]
    let end = road[1]
    let price = road[2]
    if visited[start] == visited[end] { continue }
    answer += price
    let min = visited[start] < visited[end] ? visited[start] : visited[end]
    let max = visited[start] > visited[end] ? visited[start] : visited[end]
    var nonZeroCnt = 0
    for i in 1...N{
        if visited[i] == max { visited[i] = min }
        if visited[i] != 1 { nonZeroCnt += 1 }
    }
    if nonZeroCnt == 1 { break }
}

print(answer)
