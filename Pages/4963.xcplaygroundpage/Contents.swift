import Foundation

let dx = [0,1,1,1,0,-1,-1,-1]
let dy = [1,1,0,-1,-1,-1,0,1]

func isBound(_ xx: Int, _ yy: Int, _ ROW: Int, _ COL: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}
while true{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[1]
    let COL = line[0]
    if ROW == 0 && COL == 0 { break }
    var board = [[Int]]()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    for _ in 0..<ROW{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    var answer = 0
    for i in 0..<ROW{
        for j in 0..<COL{
            if visited[i][j] || board[i][j] == 0 { continue }
            answer += 1
            var queue = [[i,j]]
            while !queue.isEmpty{
                let a = queue.removeFirst()
                for k in 0..<8{
                    let xx = a[0]+dx[k]
                    let yy = a[1]+dy[k]
                    if !isBound(xx, yy, ROW, COL) || visited[xx][yy] || board[xx][yy] == 0 { continue }
                    visited[xx][yy] = true
                    queue.append([xx,yy])
                }
            }
        }
    }
    print(answer)
}
