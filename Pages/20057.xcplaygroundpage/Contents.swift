import Foundation

var answer = 0
let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
let spinDx = [0:[-1,1,-2,2,0,-1,1,-1,1,0],
              1:[-1,-1,0,0,2,0,0,1,1,1],
              2:[-1,1,-2,2,0,-1,1,-1,1,0],
              3:[1,1,0,0,-2,0,0,-1,-1,-1]]
let spinDy = [0:[-1,-1,0,0,2,0,0,1,1,1],
              1:[-1,1,-2,2,0,-1,1,-1,1,0],
              2:[1,1,0,0,-2,0,0,-1,-1,-1],
              3:[-1,1,-2,2,0,-1,1,-1,1,0]]
let N = Int(readLine()!)!
var board: [[Int]] = []

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
var dirBoard = [[Int]](repeating: [Int](repeating: -1, count: N), count: N)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
visited[0][0] = true
dirBoard[0][0] = 2
let start = [N/2,N/2]
var x = 0
var y = 0
var dir = 0

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}
for _ in 1..<N*N{
    var xx = x+dx[dir]
    var yy = y+dy[dir]
    if !isBound(xx, yy) || visited[xx][yy]{
        dir += dir == 3 ? -3 : 1
    }
    xx = x+dx[dir]
    yy = y+dy[dir]
    
    dirBoard[xx][yy] = (dir+2)%4
    visited[xx][yy] = true
    x = xx
    y = yy
}
func spin(_ x: Int, _ y: Int, _ dust: Int, _ dir: Int){
    let per1 = dust/100
    let per2 = dust*2/100
    let per5 = dust*5/100
    let per7 = dust*7/100
    let per10 = dust/10
    var arr = [per1,per1,per2,per2,per5,per7,per7,per10,per10]
    let remain = dust-arr.reduce(0, +)
    arr.append(remain)
    for k in 0..<arr.count{
        let xx = x+spinDx[dir]![k]
        let yy = y+spinDy[dir]![k]
        if isBound(xx,yy){
            board[xx][yy] += arr[k]
            continue
        }
        answer += arr[k]
    }
}

var startX = start[0]
var startY = start[1]
for _ in 1..<N*N{
    let dir = dirBoard[startX][startY]
    let xx = startX+dx[dir]
    let yy = startY+dy[dir]
    let dust = board[xx][yy]
    spin(xx,yy,dust,dir)
    startX = xx
    startY = yy
}
print(answer)
