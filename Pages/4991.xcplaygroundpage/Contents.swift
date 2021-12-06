import Foundation

struct Point{
    let x: Int
    let y: Int
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
}
func permutation(_ n: Int) -> [[Int]]{
    var perArr = [[Int]]()
    for i in 0..<n{
        perArr += make([i], n)
    }
    return perArr
}
func make(_ visited: [Int], _ max: Int) -> [[Int]]{
    var perArr = [[Int]]()
    if visited.count == max { return [visited] }
    for i in 0..<max{
        if visited.contains(i) { continue }
        perArr += make(visited+[i], max)
    }
    return perArr
}
func isBound(_ xx: Int, _ yy: Int, _ ROW: Int, _ COL: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}
let dx = [0,1,0,-1]
let dy = [1,0,-1,0]

while true{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let COL = line[0]
    let ROW = line[1]
    if ROW == 0 && COL == 0 { break }
    var start = Point(0,0)
    var dirtyArea = [Point]()
    var board = [[String]]()
    for _ in 0..<ROW{
        board.append(readLine()!.map{String($0)})
    }
    var priceBrdArr = [[[[Int]]]](repeating: [[[Int]]](repeating: [], count: COL), count: ROW)
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == "o" { start = Point(i,j)}
            if board[i][j] == "*" { dirtyArea.append(Point(i, j))}
            if board[i][j] != "o" && board[i][j] != "*" { continue }
            var priceBrd = [[Int]](repeating: [Int](repeating: -1, count: COL), count: ROW)
            var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
            var queue = [Point(i, j)]
            priceBrd[i][j] = 0
            visited[i][j] = true
            var depth = 1
            while !queue.isEmpty{
                for _ in 0..<queue.count{
                    let a = queue.removeFirst()
                    for k in 0..<4{
                        let xx = a.x+dx[k]
                        let yy = a.y+dy[k]
                        if !isBound(xx, yy, ROW, COL) || visited[xx][yy] || board[xx][yy] == "x"{ continue }
                        priceBrd[xx][yy] = depth
                        visited[xx][yy] = true
                        queue.append(Point(xx,yy))
                    }
                }
                depth += 1
            }
            priceBrdArr[i][j] = priceBrd
        }
    }
    let permutationArr = permutation(dirtyArea.count)
    var min = Int.max
    for per in permutationArr {
        var newStart = start
        var now = 0
        for p in per{
            let price = priceBrdArr[newStart.x][newStart.y][dirtyArea[p].x][dirtyArea[p].y]
            if price == -1 {
                now = Int.max
                break
            }
            now += price
            newStart = dirtyArea[p]
        }
        min = min < now ? min : now
    }
    print(min == Int.max ? -1 : min)
}
