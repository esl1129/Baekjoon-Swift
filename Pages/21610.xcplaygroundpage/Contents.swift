import Foundation

let dx = [0,0,-1,-1,-1,0,1,1,1]
let dy = [0,-1,-1,0,1,1,1,0,-1]

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

func moveClouds(_ clouds: Set<Point>,_ dir: Int,_ cnt: Int) -> Set<Point>{
    var newClouds = Set<Point>()
    for cloud in clouds{
        var xx = cloud.x + dx[dir]*(cnt%N)
        var yy = cloud.y + dy[dir]*(cnt%N)
        xx += xx < 0 ? N : xx >= N ? -N : 0
        yy += yy < 0 ? N : yy >= N ? -N : 0
        newClouds.insert(Point(xx,yy))
    }
    
    return newClouds
}

func copyWater(_ clouds: Set<Point>){
    for cloud in clouds {
        var cnt = 0
        for k in stride(from: 2, to: 9, by: 2){
            let xx = cloud.x+dx[k]
            let yy = cloud.y+dy[k]
            if !isBound(xx, yy) || board[xx][yy] == 0 { continue }
            cnt += 1
        }
        board[cloud.x][cloud.y] += cnt
    }
}

func makeClouds(_ clouds: Set<Point>) -> Set<Point>{
    var newClouds = Set<Point>()
    for i in 0..<N{
        for j in 0..<N{
            if board[i][j] > 1 && !clouds.contains(Point(i,j)){
                board[i][j] -= 2
                newClouds.insert(Point(i,j))
            }
        }
    }
    return newClouds
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

let N = line[0]
let M = line[1]
var board: [[Int]] = []

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var clouds: Set<Point> = [Point(N-1,0),Point(N-1,1),Point(N-2,0),Point(N-2,1)]
for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    clouds = moveClouds(clouds, line[0], line[1])
    for cloud in clouds {
        board[cloud.x][cloud.y] += 1
    }
    copyWater(clouds)
    clouds = makeClouds(clouds)
}

var answer = 0
for b in board{
    answer += b.reduce(0, +)
}
print(answer)
