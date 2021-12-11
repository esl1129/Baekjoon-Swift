import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}
let dx = [0,-1,0]
let dy = [-1,0,1]
func isBound(_ xx:Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < M
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]
let D = line[2]
var board = [[Int]]()
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}



func findEnemy(_ start: Point, _ board: [[Int]]) -> Point{
    if board[start.x][start.y] == 1 {
        return start
    }
    var visited : Set<Point> = [start]
    var queue = [start]
    var depth = 1
    while !queue.isEmpty && D > depth{
        for _ in 0..<queue.count{
            let p = queue.removeFirst()
            for dir in 0..<3{
                let xx = p.x+dx[dir]
                let yy = p.y+dy[dir]
                let cp = Point(xx,yy)
                if !isBound(xx, yy) || visited.contains(cp) { continue }
                if board[xx][yy] == 1{
                    return cp
                }
                queue.append(cp)
                visited.insert(cp)
            }
        }
        depth += 1
    }
    return Point(-1,-1)
}

func solution() -> Int{
    var answer = 0
    for i in 0..<M-2{
        for j in i+1..<M-1{
            for k in j+1..<M{
                var max = 0
                var newBoard = board
                let archers = [i,j,k]
                while !newBoard.isEmpty{
                    var ans : Set<Point> = []
                    for archer in archers{
                        let p = Point(newBoard.count-1,archer)
                        ans.insert(findEnemy(p, newBoard))
                    }
                    for p in ans.filter{$0.x != -1 && $0.y != -1}{
                        newBoard[p.x][p.y] = 0
                        max += 1
                    }
                    newBoard.removeLast()
                }
                answer = answer > max ? answer : max
            }
        }
    }
    return answer
}
print(solution())
