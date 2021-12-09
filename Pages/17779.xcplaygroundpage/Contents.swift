import Foundation
let dx = [-1,0,1,0]
let dy = [0,1,0,-1]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

func find(_ p1: Point, _ p2: Point, _ p3: Point, _ p4: Point) -> Int{
    var numArr = [Int](repeating: 0, count: 5)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    var left = p1.y
    var right = p1.y
    var leftDx = -1
    var rightDx = 1
    for i in p1.x...p4.x{
        for j in left...right{
            numArr[4] += board[i][j]
            visited[i][j] = true
            if i == p2.x && j == p2.y { leftDx *= -1}
            if i == p3.x && j == p3.y { rightDx *= -1}
        }
        left += leftDx
        right += rightDx
    }
    for i in 0..<p2.x{
        for j in 0...p1.y{
            if visited[i][j] { continue }
            numArr[0] += board[i][j]
            visited[i][j] = true
        }
    }
    for i in 0...p3.x{
        for j in p1.y+1..<N{
            if visited[i][j] { continue }
            numArr[1] += board[i][j]
            visited[i][j] = true
        }
    }
    for i in p2.x..<N{
        for j in 0..<p4.y{
            if visited[i][j] { continue }
            numArr[2] += board[i][j]
            visited[i][j] = true
        }
    }
    for i in p3.x+1..<N{
        for j in p4.y..<N{
            if visited[i][j] { continue }
            numArr[3] += board[i][j]
            visited[i][j] = true
        }
    }
    return numArr.max()! - numArr.min()!
}


func isBound(_ xx:Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

let N = Int(readLine()!)!
var board = [[Int]]()
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var min = Int.max
for i in 1..<N-1{
    for j in 1..<N-1{
        for d1 in 1..<N{
            for d2 in 1..<N{
                if !isBound(i+d1, j-d1) || !isBound(i+d2, j+d2) || !isBound(i+d1+d2, j-d1+d2){ continue }
                let now = find(Point(i,j), Point(i+d1, j-d1), Point(i+d2, j+d2),Point(i+d1+d2, j-d1+d2))
                min = min < now ? min : now
            }
        }
    }
}
print(min)
