import Foundation

struct Point{
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
var answer = Int.max
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]

var board = [[Int]]()
var houses = [Point]()
var chicken = [Point]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
for i in 0..<N{
    for j in 0..<N{
        if board[i][j] == 1 { houses.append(Point(i, j))}
        if board[i][j] == 2 { chicken.append(Point(i, j))}
    }
}
var permutationArr = makePermutation(M, chicken.count)
for per in permutationArr{
    var min = 0
    for house in houses {
        var now = Int.max
        for p in per{
            let dis = abs(chicken[p].x-house.x)+abs(chicken[p].y-house.y)
            now = now < dis ? now : dis
        }
        min += now
        if min >= answer { break }
    }
    answer = answer < min ? answer : min
}
print(answer)
