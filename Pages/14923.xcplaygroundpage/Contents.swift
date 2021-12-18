import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    let cnt: Int
    init(_ x: Int, _ y: Int, _ cnt: Int){
        self.x = x
        self.y = y
        self.cnt = cnt
    }
}
let dx = [0,1,0,-1]
let dy = [1,0,-1,0]

let line1 = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line1[0]
let COL = line1[1]

let line2 = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let start = Point(line2[0]-1, line2[1]-1, 0)
let end = readLine()!.components(separatedBy: " ").map{Int(String($0))!-1}


var board = [[Int]]()

for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}


func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}

func solution() -> Int{
    var q = [start]
    var depth = 1
    var visited1 = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    var visited2 = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    visited1[start.x][start.y] = true
    visited2[start.x][start.y] = true
    while !q.isEmpty{
        for _ in q.indices{
            let a = q.removeFirst()
            for k in 0..<4{
                let xx = a.x + dx[k]
                let yy = a.y + dy[k]
                if !isBound(xx, yy){ continue }
                if board[xx][yy] == 1 && a.cnt == 1 { continue }
                if xx == end[0] && yy == end[1] { return depth }
                if board[xx][yy] == 1{
                    if visited2[xx][yy] { continue }
                    q.append(Point(xx, yy, 1))
                    visited2[xx][yy] = true
                }else{
                    if visited1[xx][yy] { continue }
                    q.append(Point(xx, yy, a.cnt))
                    visited1[xx][yy] = true
                }
            }
        }
        depth += 1
    }
    return -1
}

print(solution())
