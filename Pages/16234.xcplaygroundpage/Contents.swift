import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Point{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

struct Union{
    let sum: Int
    let cnt: Int
    let points: [Point]
}

func isBound(_ xx: Int,_ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let L = line[1]
let R = line[2]
var board = [[Int]]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
var unionArr = [Union]()
var answer = 0
while true{
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    for i in 0..<N{
        for j in 0..<N{
            if visited[i][j] { continue }
            var queue = [Point(i, j)]
            var pointArr = [Point(i,j)]
            var cnt = 0
            var sum = 0
            while !queue.isEmpty{
                let a = queue.removeFirst()
                for k in 0..<4{
                    let xx = a.x + dx[k]
                    let yy = a.y + dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] { continue }
                    let diff = abs(board[a.x][a.y]-board[xx][yy])
                    if diff < L || diff > R { continue }
                    let p = Point(xx,yy)
                    queue.append(p)
                    pointArr.append(p)
                    visited[xx][yy] = true
                    cnt += 1
                    sum += board[xx][yy]
                }
            }
            if pointArr.count == 1 { continue }
            unionArr.append(Union(sum: sum, cnt: cnt, points: pointArr))
        }
    }
    if unionArr.isEmpty { break }
    
    for union in unionArr{
        let value = union.sum/union.cnt
        for point in union.points{
            board[point.x][point.y] = value
        }
    }
    answer += 1
    unionArr = []
}

print(answer)
