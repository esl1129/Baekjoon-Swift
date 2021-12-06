import Foundation

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}

func operate(_ x: Int, _ y: Int, _ dir: Int){
    var x = x
    x += dir == 3 ? -1 : dir == 4 ? 1 : 0
    var y = y
    y += dir == 2 ? -1 : dir == 1 ? 1 : 0
    let wallChk = dir
    var dxy = dirDict[dir]!
    var queue = [[x,y]]
    sumBoard[x][y] += 5
    var depth = 4
    while !queue.isEmpty{
        for _ in 0..<queue.count{
            let a = queue.removeFirst()
            for move in dxy{
                
            }
        }
    }
}
let dx = [0,1,1,1,0,-1,-1,-1]
let dy = [1,1,0,-1,-1,-1,0,1]
let dirDict = [0:[0,2,4,6],1:[0,1,7],2:[3,4,5],3:[5,6,7],4:[1,2,3]]

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]
let K = line[2]

var board: [[Int]] = []
var wall: Set<[Int]> = []
var sumBoard = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)

for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

let M = Int(readLine()!)!

for _ in 0..<M{
    wall.insert(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
for i in 0..<ROW{
    for j in 0..<COL{
        if board [i][j] < 1 || board[i][j] > 4 { continue }
        var point = [i,j]
    }
}

