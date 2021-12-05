import Foundation

let dirDx = [0,1,0,-1]
let dirDy = [1,0,-1,0]
let dx = [0,-1,1,0,0]
let dy = [0,0,0,-1,1]

struct Point: Hashable{
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}
func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

let N = line[0]
let M = line[1]

var dirBoard = [[Int]](repeating: [Int](repeating: -1, count: N), count: N)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
var board: [[Int]] = []
visited[0][0] = true
dirBoard[0][0] = 2
let center = Point(N/2, N/2)
var x = 0
var y = 0
var dir = 0

var ex = [0,0,0,0]
for _ in 1..<N*N{
    var xx = x+dirDx[dir]
    var yy = y+dirDy[dir]
    if !isBound(xx, yy) || visited[xx][yy]{
        dir += dir == 3 ? -3 : 1
    }
    xx = x+dirDx[dir]
    yy = y+dirDy[dir]
    
    dirBoard[xx][yy] = (dir+2)%4
    visited[xx][yy] = true
    x = xx
    y = yy
}

func setting() -> Int{
    let arr = explosion()
    var newBoard = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    var point = center
    for a in arr{
        let dir = dirBoard[point.x][point.y]
        let xx = point.x+dirDx[dir]
        let yy = point.y+dirDy[dir]
        newBoard[xx][yy] = a
        point = Point(xx,yy)
    }
    board = newBoard
    return arr.count
}

func multiplication(){
    let arr = explosion()
    var newArr: [Int] = []
    var num = 0
    var cnt = 0
    for a in arr{
        if a == num{
            cnt += 1
        }
        if cnt == 0 { continue }
        newArr.append(cnt)
        newArr.append(num)
        cnt = 1
        num = a
    }
    var newBoard = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    var point = center
    for a in newArr{
        let dir = dirBoard[point.x][point.y]
        let xx = point.x+dirDx[dir]
        let yy = point.y+dirDy[dir]
        newBoard[xx][yy] = a
        point = Point(xx,yy)
    }
    board = newBoard
}
func explosion() -> [Int]{
    var numArr: [Int] = []
    var point = center
    var cnt = 0
    var num = 0
    while true{
        let dir = dirBoard[point.x][point.y]
        let xx = point.x+dirDx[dir]
        let yy = point.y+dirDy[dir]
        point = Point(xx,yy)
        if xx == 0 && yy == -1{
            if cnt > 3{
                ex[num] += cnt
            }else{
                numArr.append(contentsOf: [Int](repeating: num, count: cnt))
            }
            break
        }
        if board[xx][yy] == 0 { break }
        if board[xx][yy] == -1 { continue }
        if board[xx][yy] == num{
            cnt += 1
            continue
        }
        if cnt > 3{
            ex[num] += cnt
        }else{
            numArr.append(contentsOf: [Int](repeating: num, count: cnt))
        }
        cnt = 1
        num = board[xx][yy]
    }
    print(numArr)
    return numArr
}
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let dir = line[0]
    let cnt = line[1]
    for i in 1...cnt{
        board[center.x+dx[dir]*i][center.y+dy[dir]*i] = -1
    }
    var size = 0
    while true{
        let now = setting()
        if size == now { break }
        size = now
    }
    //multiplication()
}
print(ex.enumerated().map{ (index, num) in
    return index*num
}.reduce(0, +))
