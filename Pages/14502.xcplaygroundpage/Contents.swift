import Foundation

struct Point{
    let x: Int
    let y: Int
}
func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}

func BFS(_ p1: Point, _ p2: Point, _ p3:Point) -> Int{
    var newBoard = board
    newBoard[p1.x][p1.y] = 1
    newBoard[p2.x][p2.y] = 1
    newBoard[p3.x][p3.y] = 1
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    for virusPoint in virusPoints {
        var queue = [virusPoint]
        visited[virusPoint.x][virusPoint.y] = true
        while !queue.isEmpty{
            let p = queue.removeFirst()
            for k in 0..<4{
                let xx = p.x+dx[k]
                let yy = p.y+dy[k]
                if isBound(xx, yy) && !visited[xx][yy] && newBoard[xx][yy] == 0{
                    newBoard[xx][yy] = 2
                    queue.append(Point(x: xx, y: yy))
                    visited[xx][yy] = true
                }
            }
        }
    }
    return newBoard.flatMap{ $0 }.filter{$0 == 0}.count
}

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]

var board: [[Int]] = []

for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var safePoints = [Point]()
var virusPoints = [Point]()
for i in 0..<ROW{
    for j in 0..<COL{
        if board[i][j] == 0 {
            safePoints.append(Point(x: i, y: j))
        }
        if board[i][j] == 2 {
            virusPoints.append(Point(x: i, y: j))
        }
    }
}

let size = safePoints.count
var answer = 0
for i in 0..<size-2{
    for j in i+1..<size-1{
        for k in j+1..<size{
            let now = BFS(safePoints[i], safePoints[j], safePoints[k])
            answer = now > answer ? now : answer
        }
    }
}
print(answer)
