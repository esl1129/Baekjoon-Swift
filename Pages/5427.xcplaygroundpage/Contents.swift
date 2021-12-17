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

func solution(_ ROW: Int,_ COL: Int) -> String{
    var board = [[String]]()
    for _ in 0..<ROW{
        board.append(readLine()!.map{String($0)})
    }
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    var fireVisited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    
    var personQ = [Point]()
    var fireQ = [Point]()
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == "*" {
                fireQ.append(Point(i, j))
                fireVisited[i][j] = true
            }
            if board[i][j] == "@" {
                personQ.append(Point(i, j))
                visited[i][j] = true
            }
        }
    }
    var answer = 1
    while !personQ.isEmpty{
        for _ in personQ.indices{
            let a = personQ.removeFirst()
            for k in 0..<4{
                let xx = a.x + dx[k]
                let yy = a.y + dy[k]
                if !isBound(xx, yy) { return String(answer) }
                if board[xx][yy] == "#" || visited[xx][yy] { continue }
                var check = true
                for r in 0..<4{
                    let xxx = xx+dx[r]
                    let yyy = yy+dy[r]
                    if !isBound(xxx, yyy) || board[xxx][yyy] == "#"{ continue }
                    if board[xxx][yyy] == "*" { check = false }
                }
                if check{
                    personQ.append(Point(xx, yy))
                    visited[xx][yy] = true
                }
            }
        }
        for _ in fireQ.indices{
            let f = fireQ.removeFirst()
            for k in 0..<4{
                let xx = f.x + dx[k]
                let yy = f.y + dy[k]
                if !isBound(xx, yy) { continue }
                if board[xx][yy] == "#" || fireVisited[xx][yy] { continue }
                board[xx][yy] = "*"
                fireQ.append(Point(xx, yy))
                fireVisited[xx][yy] = true
            }
        }
        answer += 1
    }
    return "IMPOSSIBLE"
}
let TC = Int(readLine()!)!
for _ in 0..<TC{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[1]
    let COL = line[0]
    print(solution(ROW,COL))
}
