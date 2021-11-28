import Foundation

enum Dir: Int{
    case right,up,left,down
}
struct Point: Hashable{
    var x : Int
    var y : Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}
let dx = [0,-1,0,1]
let dy = [1,0,-1,0]
let n = Int(readLine()!)!
let k = Int(readLine()!)!
var appleSet = Set<Point>()

for _ in 0..<k{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    appleSet.insert(Point(line[0], line[1]))
}
let l = Int(readLine()!)!
var moveDict: [Int:String] = [:]

for _ in 0..<l{
    let line = readLine()!.components(separatedBy: " ").map{String($0)}
    moveDict[Int(line[0])!] = line[1]
}

func solution(_ n: Int,_ moves: [Int:String]) -> Int{
    func check(_ xx: Int, _ yy: Int) -> Bool{
        return xx > 0 && yy > 0 && xx <= n && yy <= n
    }
    
    func changeDir(_ key: Int){
        switch snakeDir{
        case .down:
            snakeDir = moveDict[key] == "D" ? .left : .right
        case .up:
            snakeDir = moveDict[key] == "D" ? .right : .left
        case .left:
            snakeDir = moveDict[key] == "D" ? .up : .down
        case .right:
            snakeDir = moveDict[key] == "D" ? .down : .up
        }
    }
    
    var snakeDir: Dir = .right
    var point = Point(1, 1)
    var pointArr: [Point] = [point]
    var cnt = 0
    while true{
        cnt += 1
        point.x = point.x + dx[snakeDir.rawValue]
        point.y = point.y + dy[snakeDir.rawValue]
        if !check(point.x,point.y) || pointArr.contains(point){ break }
        pointArr.append(point)
        if moveDict[cnt] != nil{
            changeDir(cnt)
        }
        if appleSet.contains(point) {
            appleSet.remove(point)
            continue
        }
        pointArr.removeFirst()
    }
    return cnt
}


print(solution(n,moveDict))
