import Foundation
func solution() -> String{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let MAX = line[0]
    let s = line[1]
    let end = line[2]
    if s == end { return "0" }
    let up = line[3]
    let down = line[4]
    var visited = [Bool](repeating: false, count: MAX+1)
    visited[s] = true
    var queue = [s]
    var answer = 1
    while !queue.isEmpty{
        for _ in queue.indices{
            let a = queue.removeFirst()
            if a+up <= MAX {
                if !visited[a+up]{
                    if a+up == end { return String(answer) }
                    visited[a+up] = true
                    queue.append(a+up)
                }
            }
            if a-down > 0 {
                if !visited[a-down]{
                    if a-down == end { return String(answer) }
                    visited[a-down] = true
                    queue.append(a-down)
                }
            }
        }
        answer += 1
    }
    return "use the stairs"
}

print(solution())
