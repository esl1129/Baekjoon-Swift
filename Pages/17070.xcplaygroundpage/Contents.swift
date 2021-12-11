import Foundation

let dx = [1,0,1]
let dy = [0,1,1]
func isBound(_ pp: Int) -> Bool{
    return pp >= 0 && pp < N
}

let N = Int(readLine()!)!
var board = [[Int]]()
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
var sumBoard = [[[Int]]](repeating: [[Int]](repeating: [0,0,0], count: N), count: N)
sumBoard[0][1][0] = 1
for i in 0..<N{
    for j in 0..<N{
        if isBound(i-1) && isBound(j-1) && board[i][j-1] == 0 && board[i-1][j] == 0 && board[i][j] == 0{
            sumBoard[i][j][2] += sumBoard[i-1][j-1].reduce(0, +)
        }
        if isBound(i-1) && board[i-1][j] == 0 && board[i][j] == 0{
            sumBoard[i][j][1] += sumBoard[i-1][j][1]+sumBoard[i-1][j][2]
        }
        if isBound(j-1) && board[i][j-1] == 0 && board[i][j] == 0{
            sumBoard[i][j][0] += sumBoard[i][j-1][0]+sumBoard[i][j-1][2]
        }
    }
}
print(sumBoard[N-1][N-1].reduce(0, +))
