import Foundation

let dx = [0,0,1,0,-1]
let dy = [0,1,0,-1,0]

struct Point: Hashable{
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

struct Dice{
    var up: Int = 0
    var down: Int = 0
    var north: Int = 0
    var south: Int = 0
    var west: Int = 0
    var east: Int = 0
    
    mutating func rotate(_ dir: Int){
        let temp = self.up
        // 1 -> right, 2 -> down, 3 -> left, 4 -> up
        switch dir{
        case 1:
            self.up = self.west
            self.west = self.down
            self.down = self.east
            self.east = temp
        case 2:
            self.up = self.north
            self.north = self.down
            self.down = self.south
            self.south = temp
        case 3:
            self.up = self.east
            self.east = self.down
            self.down = self.west
            self.west = temp
        case 4:
            self.up = self.south
            self.south = self.down
            self.down = self.north
            self.north = temp
        
        default:
            break
        }
    }
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < M
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

let N = line[0]
let M = line[1]
let move = line[2]
var board: [[Int]] = []
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
var sumBoard = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
for i in 0..<N{
    for j in 0..<M{
        if visited[i][j] { continue }
        var pointSet: Set<Point> = [Point(i,j)]
        var queue = [Point(i,j)]
        let num = board[i][j]
        while !queue.isEmpty{
            let a = queue.removeFirst()
            for k in 1...4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] != num{ continue }
                let newP = Point(xx,yy)
                visited[xx][yy] = true
                pointSet.insert(newP)
                queue.append(newP)
            }
        }
        let sum = num*pointSet.count
        for point in pointSet{
            sumBoard[point.x][point.y] = sum
        }
    }
}

var answer = 0
var point = Point(0,0)
var dir = 1
var dice = Dice(up: 1, down: 6, north: 2, south: 5, west: 4, east: 3)
for _ in 0..<move{
    var xx = point.x+dx[dir]
    var yy = point.y+dy[dir]
    if xx < 0 || yy < 0 || xx >= N || yy >= M{
        dir = (dir+2)%4
        if dir == 0 { dir = 4}
        xx = point.x+dx[dir]
        yy = point.y+dy[dir]
    }
    point = Point(xx,yy)
    dice.rotate(dir)
    answer += sumBoard[xx][yy]
    if dice.down == board[xx][yy] { continue }
    dir += dice.down < board[xx][yy] ? -1 : 1
    if dir < 1 { dir += 4 }
    if dir > 4 { dir -= 4 }
}
print(answer)
