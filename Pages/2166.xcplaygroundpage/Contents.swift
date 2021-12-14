import Foundation

struct Point{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

let N = Int(readLine()!)!
var board = [Point]()

for _ in 0..<N{
    let n = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    board.append(Point(n[0], n[1]))
}
board.append(board[0])

var answer = 0
for i in 0..<N{
    answer += board[i].x*board[i+1].y
    answer -= board[i].y*board[i+1].x
}

print(String(format: "%.1f", abs(Double(answer)/2)))
