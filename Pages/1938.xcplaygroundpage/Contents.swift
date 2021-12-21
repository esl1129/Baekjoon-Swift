import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}
struct Tree: Hashable{
    var p1: Point
    var p2: Point
    var p3: Point
    init(_ p1: Point, _ p2: Point, _ p3: Point){
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
    }
    func move(_ dir: Int) -> Tree{
        return Tree(Point(p1.x+dx[dir], p1.y+dy[dir]), Point(p2.x+dx[dir], p2.y+dy[dir]), Point(p3.x+dx[dir], p3.y+dy[dir]))
    }
    func rotateCheck() -> Bool{
        for i in p2.x-1...p2.x+1{
            for j in p2.y-1...p2.y+1{
                if !isBound(i, j) || board[i][j] == "1" { return false }
            }
        }
        return true
    }
    func rotate() -> Tree{
        if p1.x == p2.x && p2.x == p3.x{
            return Tree(Point(p2.x-1, p2.y), p2, Point(p2.x+1, p2.y))
        }
        return Tree(Point(p2.x, p2.y-1), p2, Point(p2.x, p2.y+1))
    }
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}
func isBoundTree(_ t: Tree) -> Bool{
    return t.p1.x >= 0 && t.p1.y >= 0 && t.p2.x >= 0 && t.p2.y >= 0 && t.p3.x >= 0 && t.p3.y >= 0 && t.p1.x < N && t.p1.y < N && t.p2.x < N && t.p2.y < N && t.p3.x < N && t.p3.y < N
}
func isCheck(_ t: Tree) -> Bool{
    return board[t.p1.x][t.p1.y] != "1" && board[t.p2.x][t.p2.y] != "1" && board[t.p3.x][t.p3.y] != "1"
}
let N = Int(readLine()!)!
var board = [[String]]()

for _ in 0..<N{
    board.append(readLine()!.map{String($0)})
}


func solution(_ board: [[String]]) -> Int{
    var start = Tree(Point(0, 0), Point(0, 0), Point(0, 0))
    var end = Tree(Point(0, 0), Point(0, 0), Point(0, 0))
    var visited = Set<Tree>()
    for i in 0..<N{
        for j in 0..<N{
            if board[i][j] == "B" {
                start.p1 = start.p2
                start.p2 = start.p3
                start.p3 = Point(i, j)
            }
            if board[i][j] == "E" {
                end.p1 = end.p2
                end.p2 = end.p3
                end.p3 = Point(i, j)
            }
        }
    }
    var q = [start]
    visited.insert(start)
    var answer = 1

    while !q.isEmpty{
        for _ in q.indices{
            let t = q.removeFirst()
            for k in 0..<4{
                let now = t.move(k)
                if !isBoundTree(now) || visited.contains(now) || !isCheck(now){ continue }
                if now == end { return answer }
                q.append(now)
                visited.insert(now)
            }
            if t.rotateCheck(){
                let now = t.rotate()
                if !isBoundTree(now) || visited.contains(now) || !isCheck(now){ continue }
                if now == end { return answer }
                q.append(now)
                visited.insert(now)
            }
        }
        answer += 1
    }
    return 0
}

print(solution(board))
