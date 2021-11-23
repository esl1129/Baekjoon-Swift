import Foundation
var n = Int(readLine()!)!
var board = [[Int]]()
var boardSet = [[[Set<Int>]]](repeating: [[Set<Int>]](repeating: [], count: n), count: n)

for _ in 0..<n{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
boardSet[0][0].append([board[0][0]])
for i in 0..<n{
    for j in 0..<n{
        for b in boardSet[i][j]{
            if i < n-1{
                var newSet = b
                newSet.insert(board[i+1][j])
                boardSet[i+1][j].append(newSet)
            }
            if j < n-1{
                var newSet = b
                newSet.insert(board[i][j+1])
                boardSet[i][j+1].append(newSet)
            }
        }
        
    }
}
var min = Int.max
for arr in boardSet[n-1][n-1]{
    min = arr.max()! - arr.min()! < min ? arr.max()! - arr.min()! : min
}
print(min)
