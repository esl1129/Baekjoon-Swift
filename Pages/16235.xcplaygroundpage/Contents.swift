import Foundation

let dx = [0,1,1,1,0,-1,-1,-1]
let dy = [1,1,0,-1,-1,-1,0,1]
func isBound(_ xx: Int,_ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]
let K = line[2]
var defaultBoard = [[Int]]()
var treeArr = [[[Int]]](repeating: [[Int]](repeating: [], count: N), count: N)
for _ in 0..<N{
    defaultBoard.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    treeArr[line[0]-1][line[1]-1].append(line[2])
}

var board = [[Int]](repeating: [Int](repeating: 5, count: N), count: N)
for _ in 0..<K{
    var newTrees = [[[Int]]](repeating: [[Int]](repeating: [], count: N), count: N)
    for i in 0..<N{
        for j in 0..<N{
            var dead = defaultBoard[i][j]
            if treeArr[i][j].isEmpty {
                board[i][j] += dead
                continue
            }
            var sum = treeArr[i][j].map{$0/2}.reduce(0, +)
            for age in treeArr[i][j].sorted{$0 < $1} {
                if board[i][j] < age{
                    dead += sum
                    break
                }
                board[i][j] -= age
                sum -= age/2
                newTrees[i][j].append(age+1)
                if age%5 == 4{
                    for k in 0..<8{
                        let xx = i+dx[k]
                        let yy = j+dy[k]
                        if !isBound(xx, yy) { continue }
                        newTrees[xx][yy].append(1)
                    }
                }
            }
            board[i][j] += dead
        }
    }
    treeArr = newTrees
}
print(treeArr.flatMap{$0}.flatMap{$0}.count)
