import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]

func isBound(_ xx:Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

var board = [[Int]]()
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

func DFS(_ start: Point, _ depth: Int, _ visited: Set<Point>, _ cnt: Int) -> Int{
    if depth == M {
        return cnt
    }
    var max = 0
    for k in 0..<4{
        let xx = start.x + dx[k]
        let yy = start.y + dy[k]
        if !isBound(xx, yy) { continue }
        let p = Point(xx,yy)
        if visited.contains(p) { continue }
        let now = DFS(p, depth+1, visited.union([p]), cnt+board[xx][yy])
        max = max > now ? max : now
    }
    return max
}

func solution() -> Int{
    var max = 0
    for i in 0..<N{
        for j in 0..<N{
            let p = Point(i,j)
            let now = DFS(p, 1, [p], board[i][j])
            max = max > now ? max : now
        }
    }
    return max
}


print(solution())
