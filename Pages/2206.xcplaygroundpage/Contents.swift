import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Point: Hashable{
    let x: Int
    let y: Int
    let p: Int
    init(_ x: Int, _ y: Int, _ p: Int){
        self.x = x
        self.y = y
        self.p = p
    }
}


func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]
var board = [[Int]]()
for _ in 0..<ROW{
    board.append(readLine()!.map{Int(String($0))!})
}
func solution() -> Int{
    if ROW == 1 && COL == 1 { return 1 }
    var visited = [[[Bool]]](repeating: [[Bool]](repeating: [false,false], count: COL), count: ROW)
    visited[0][0][0] = true
    var q = [Point(0, 0, 0)]
    var cnt = 2
    while !q.isEmpty{
        for _ in q.indices{
            let a = q.removeFirst()
            for k in 0..<4{
                let xx = a.x + dx[k]
                let yy = a.y + dy[k]
                if !isBound(xx, yy){ continue }
                if xx == ROW-1 && yy == COL-1 { return cnt }
                if board[xx][yy] == 1 && a.p == 1 { continue }
                if visited[xx][yy][a.p+board[xx][yy]] { continue }
                q.append(Point(xx, yy, a.p+board[xx][yy]))
                visited[xx][yy][a.p+board[xx][yy]] = true
            }
        }
        cnt += 1
    }
    return -1
}

print(solution())
