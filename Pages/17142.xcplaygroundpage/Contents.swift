import Foundation
let dx = [-1,0,1,0]
let dy = [0,1,0,-1]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

func makePermutation(_ r: Int, _ n: Int) -> Set<Set<Int>>{
    return permutation([], n, r,0)
}
func permutation(_ arr: Set<Int>, _ n: Int, _ r: Int, _ start: Int) -> Set<Set<Int>>{
    if arr.count == r{
        return [arr]
    }
    var list = Set<Set<Int>>()
    for i in start..<n{
        if !arr.contains(i){
            list = list.union(permutation(arr.union([i]), n, r, i+1))
        }
    }
    return list
}

func isBound(_ xx:Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

func BFS(_ startSet: Set<Int>,_ emptyArea: Set<Point>) -> Int{
    var empty = emptyArea
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    var queue = [Point]()
    for index in startSet{
        queue.append(virus[index])
        visited[virus[index].x][virus[index].y] = true
    }
    var depth = 1
    while !queue.isEmpty{
        for _ in 0..<queue.count{
            let a = queue.removeFirst()
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] == 1{ continue }
                let p = Point(xx,yy)
                queue.append(p)
                visited[xx][yy] = true
                empty.remove(p)
            }
        }
        if empty.isEmpty{
            return depth
        }
        depth += 1
    }
    
    return -1
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]
var board = [[Int]]()
var emptyArea = Set<Point>()
var virus = [Point]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
for i in 0..<N{
    for j in 0..<N{
        if board[i][j] == 0 { emptyArea.insert(Point(i, j))}
        if board[i][j] == 2 { virus.append(Point(i, j))}
    }
}
if emptyArea.isEmpty{
    print(0)
}else{
    let permutationArr = makePermutation(M, virus.count)
    var min = -1
    for per in permutationArr{
        let now = BFS(per, emptyArea)
        if now == -1 { continue }
        min = min == -1 ? now : min < now ? min : now
    }
    print(min)
}

