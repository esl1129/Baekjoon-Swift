import Foundation

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]
var brd = [[Int]]()
var sumBrd = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)

for i in 0..<ROW{
    brd.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    if brd[i][0] == 0 { sumBrd[i][0] = 1 }
}
for i in 0..<COL{
    if brd[0][i] == 0 { sumBrd[0][i] = 1 }
}

var max = 0
for i in 1..<ROW{
    for j in 1..<COL{
        if brd[i][j] != 0 { continue }
        sumBrd[i][j] = [sumBrd[i-1][j],sumBrd[i][j-1],sumBrd[i-1][j-1]].min()!+1
        max = max > sumBrd[i][j] ? max : sumBrd[i][j]
    }
}
print(max)
