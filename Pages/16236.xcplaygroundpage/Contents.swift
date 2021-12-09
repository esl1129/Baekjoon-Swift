import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

func isBound(_ xx:Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}
let dx = [-1,0,0,1]
let dy = [0,-1,1,0]

let N = Int(readLine()!)!
var board = [[Int]]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var level = 2
var time = 0
var start = Point(0, 0)
for i in 0..<N{
    for j in 0..<N{
        if board[i][j] == 9 {
            start = Point(i,j)
            break
        }
    }
}

func BFS(_ p: Point) -> Point{
    var queue = [p]
    var depth = 1
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    visited[p.x][p.y] = true
    while !queue.isEmpty{
        var pointSet = [Point]()
        for _ in 0..<queue.count{
            let a = queue.removeFirst()
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] > level{ continue }
                if board[xx][yy] != 0 && board[xx][yy] < level {
                    pointSet.append(Point(xx,yy))
                }
                queue.append(Point(xx, yy))
                visited[xx][yy] = true
            }
        }
        if !pointSet.isEmpty{
            time += depth
            let sorted = pointSet.sorted{$0.x < $1.x}
            let sorted2 = sorted.sorted{$0.x <= $1.x && $0.y < $1.y}
            let point = sorted2.first!
            board[p.x][p.y] = 0
            board[point.x][point.y] = 9
            return point
        }
        depth += 1
    }
    return Point(-1,-1)
}
var eat = 0
while true{
    if start.x == -1 { break }
    start = BFS(start)
    eat += 1
    if eat == level{
        level += 1
        eat = 0
    }
}
print(time)
