import Foundation

var iceMax = 0
let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = Int(pow(2.0,Double(line[0])))
let Q = line[1]
var board: [[Int]] = []
for _ in 0..<N{
    let arr = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    board.append(arr)
    iceMax += arr.reduce(0, +)
}

func spin(_ range: Int){
    var newBoard = board
    for x in stride(from: 0, to: N, by: range){
        for y in stride(from: 0, to: N, by: range){
            for i in 0..<range{
                for j in 0..<range{
                    newBoard[x+j][y+range-i-1] = board[x+i][y+j]
                }
            }
        }
    }
    board = newBoard
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

func removeIce(){
    var removeSet = Set<[Int]>()
    for i in 0..<N{
        for j in 0..<N{
            if board[i][j] <= 0 { continue }
            var cnt = 0
            for k in 0..<4{
                let xx = i+dx[k]
                let yy = j+dy[k]
                if !isBound(xx, yy) || board[xx][yy] <= 0 { continue }
                cnt += 1
            }
            if cnt < 3 {
                removeSet.insert([i,j])
                iceMax -= 1
            }
        }
    }
    for point in removeSet{
        board[point[0]][point[1]] -= 1
    }
}

func BFS() -> Int{
    var max = 0
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    for i in 0..<N{
        for j in 0..<N{
            if visited[i][j] || board[i][j] == 0 { continue }
            visited[i][j] = true
            var cnt = 1
            var queue = [[i,j]]
            while !queue.isEmpty{
                let p = queue.removeFirst()
                for k in 0..<4{
                    let xx = p[0]+dx[k]
                    let yy = p[1]+dy[k]
                    if isBound(xx, yy) && !visited[xx][yy] && board[xx][yy] > 0{
                        queue.append([xx,yy])
                        cnt += 1
                        visited[xx][yy] = true
                    }
                }
            }
            max = max > cnt ? max : cnt
        }
    }
    return max
}

var skills = readLine()!.components(separatedBy: " ").map{Int(pow(2.0,Double(String($0))!))}

for skill in skills{
    spin(skill)
    removeIce()
}


print(iceMax)
print(BFS())
