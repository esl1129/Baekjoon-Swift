import Foundation

let N = Int(readLine()!)!
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let start = line[0]
let end = line[1]
let M = Int(readLine()!)!

var board = [[Int]](repeating: [], count: N+1)
var visited = [Bool](repeating: false, count: N+1)

for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    board[line[0]].append(line[1])
    board[line[1]].append(line[0])
}
var queue = [start]
var range = 1
var answer = 0
visited[start] = true

func solution() -> Int{
    while !queue.isEmpty{
        for _ in queue.indices{
            let a = queue.removeFirst()
            for num in board[a]{
                if visited[num] { continue }
                visited[num] = true
                if num == end{
                    return range
                }
                queue.append(num)
            }
        }
        range += 1
    }
    return -1
}

print(solution())
