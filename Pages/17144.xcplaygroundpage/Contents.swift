import Foundation
let dxUp = [-1,0,1,0]
let dxDown = [1,0,-1,0]
let dy = [0,1,0,-1]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

func isBound(_ xx:Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}
func rotate(_ up: Point, _ down: Point){
    var startP = up
    var dir = 0
    while true{
        var xx = startP.x+dxUp[dir]
        var yy = startP.y+dy[dir]
        if xx == up.x && yy == up.y{
            board[startP.x][startP.y] = 0
            break
        }
        if !isBound(xx, yy) || xx > up.x{
            dir += 1
            xx = startP.x+dxUp[dir]
            yy = startP.y+dy[dir]
        }
        board[startP.x][startP.y] = board[xx][yy]
        startP = Point(xx,yy)
    }
    startP = down
    dir = 0
    while true{
        var xx = startP.x+dxDown[dir]
        var yy = startP.y+dy[dir]
        if xx == down.x && yy == down.y{
            board[startP.x][startP.y] = 0
            break
        }
        if !isBound(xx, yy) || xx < down.x {
            dir += 1
            xx = startP.x+dxDown[dir]
            yy = startP.y+dy[dir]
        }
        board[startP.x][startP.y] = board[xx][yy]
        startP = Point(xx,yy)
    }
    board[up.x][up.y] = 0
    board[down.x][down.y] = 0
}

func diffusion(){
    var newBoard = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == 0 { continue }
            var num = board[i][j]
            let diffNum = num/5
            for k in 0..<4{
                let xx = i+dxUp[k]
                let yy = j+dy[k]
                if !isBound(xx, yy) || up.x == xx && up.y == yy || down.x == xx && down.y == yy { continue }
                newBoard[xx][yy] += diffNum
                num -= diffNum
            }
            newBoard[i][j] += num
        }
    }
    board = newBoard
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]
let T = line[2]

var board = [[Int]]()
for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var air = [Point]()
for j in 0..<ROW{
    if board[j][0] == -1{
        board[j][0] = 0
        air.append(Point(j, 0))
    }
}
let up = air[0]
let down = air[1]

for _ in 0..<T{
    diffusion()
    rotate(up, down)
}

var answer = 0
for b in board{
    answer += b.reduce(0, +)
}
print(answer)
