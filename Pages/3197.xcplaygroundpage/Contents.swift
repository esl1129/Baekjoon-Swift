import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}

func findWay(_ mid: Int) -> Bool{
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    let start = swan[0]
    let end = swan[1]
    visited[start.x][start.y] = true
    var queue = [start]
    while !queue.isEmpty{
        let a = queue.removeFirst()
        for k in 0..<4{
            let xx = a.x + dx[k]
            let yy = a.y + dy[k]
            if !isBound(xx, yy) || visited[xx][yy] || priceBoard[xx][yy] > mid{ continue }
            if xx == end.x && yy == end.y { return true}
            queue.append(Point(xx, yy))
            visited[xx][yy] = true
        }
    }
    return false
}

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]

var board = [[String]]()
var iceSet = [Point]()
for _ in 0..<ROW{
    board.append(readLine()!.map{String($0)})
}

var swan = [Point]()
var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
for i in 0..<ROW{
    for j in 0..<COL{
        if board[i][j] == "L" { swan.append(Point(i, j))}
        if board[i][j] == "X" {
            for k in 0..<4{
                let xx = i+dx[k]
                let yy = j+dy[k]
                if !isBound(xx, yy) || iceSet.contains(Point(xx, yy)) || board[xx][yy] != "." { continue }
                iceSet.append(Point(i, j))
                visited[i][j] = true
                break
            }
        }
    }
}

var priceBoard = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)
var price = 1
while !iceSet.isEmpty{
    for _ in 0..<iceSet.count{
        let a = iceSet.removeFirst()
        priceBoard[a.x][a.y] = price
        board[a.x][a.y] = "."
        for k in 0..<4{
            let xx = a.x+dx[k]
            let yy = a.y+dy[k]
            if !isBound(xx, yy) || board[xx][yy] != "X" || visited[xx][yy] { continue }
            iceSet.append(Point(xx,yy))
            visited[xx][yy] = true
        }
    }
    price += 1
}

var start = 0

while start <= price{
    let mid = (start+price)/2
    if findWay(mid){
        price = mid-1
    }else{
        start = mid+1
    }
}
print(start)
