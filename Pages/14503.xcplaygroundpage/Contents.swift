import Foundation

struct Point{
    let x: Int
    let y: Int
}

struct Robot{
    let point: Point
    let dir: Int
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}

func BFS(_ robot: Robot) -> Int{
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    var queue = [robot]
    var cleanCnt = 1
    visited[robot.point.x][robot.point.y] = true
    while !queue.isEmpty{
        let currentRobot = queue.removeFirst()
        var dir = currentRobot.dir
        var check = false
        for _ in 0..<4{
            dir -= dir == 0 ? -3 : 1
            let xx = currentRobot.point.x+dx[dir]
            let yy = currentRobot.point.y+dy[dir]
            if isBound(xx, yy) && board[xx][yy] != 1 && !visited[xx][yy]{
                queue.append(Robot(point: Point(x: xx, y: yy), dir: dir))
                visited[xx][yy] = true
                cleanCnt += 1
                check = true
                break
            }
        }
        if !check{
            let xx = currentRobot.point.x-dx[currentRobot.dir]
            let yy = currentRobot.point.y-dy[currentRobot.dir]
            if isBound(xx, yy) && board[xx][yy] != 1{
                queue.append(Robot(point: Point(x: xx, y: yy), dir: currentRobot.dir))
            }
        }
    }
    return cleanCnt
}

let dx = [-1,0,1,0]
let dy = [0,1,0,-1]

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]

let a = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
var robot = Robot(point: Point(x: a[0], y: a[1]), dir: a[2])
var board: [[Int]] = []

for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

print(BFS(robot))
