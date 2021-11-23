import Foundation

func makeBoard(_ board: [[Int]], _ board2: [[Int]], _ n: Int) -> [[Int]]{
    var newBoard = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    
    for i in 0..<n{
        for j in 0..<n{
            var ans = 0
            for k in 0..<n{
                ans += (board[i][k]*board2[k][j])%1000
            }
            newBoard[i][j] = ans%1000
        }
    }
    
    return newBoard
}

var line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
var n = line[0]
var k = line[1]
let decimalK = String(k, radix: 2)
var board = [[Int]]()
var boardSet = [[[Int]]]()
for _ in 0..<n{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    board.append(line)
}
boardSet.append(board)

for _ in 1..<decimalK.count{
    board = makeBoard(board, board, n)
    boardSet.append(board)
}

var initBrd = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
for i in 0..<n{
    initBrd[i][i] = 1
}

for (index, value) in decimalK.reversed().enumerated(){
    if value == "1"{
        initBrd = makeBoard(initBrd,boardSet[index],n)
    }
}
print(initBrd)

