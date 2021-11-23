import Foundation


let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let a = line[0]
let b = line[1]
var board = [[String]]()
let dx = [-1,0,1,0]
let dy = [0,-1,0,1]
var start = [Int]()
var end = [Int]()

for i in 0..<a{
    let line = readLine()!.map{String($0)}
    if line.contains("L"){
        if start.isEmpty{
            start = [i,line.firstIndex(of: "L")!]
        }else{
            end = [i,line.firstIndex(of: "L")!]
        }
        board.append(line)
    }
}


func solution(_ board: [[String]],_ row: Int,_ col: Int, _ start: [Int], _ end: [Int]) -> Int{
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: col), count: row)
    visited[start[0]][start[1]] = true
    var queue = [[start[0],start[1],0]]
    var min = Int.max
    while !queue.isEmpty{
        let point = queue.removeFirst()
        for k in 0..<4{
            let xx = point[0]+dx[k]
            let yy = point[1]+dy[k]
            if !isBound(xx,yy) || visited[xx][yy] { continue }
            
            var cnt = point[2]
            if board[xx][yy] == "X" { cnt += 1}
            else {
                min = cnt < min && cnt != 0 ? cnt : min
                cnt = 0
            }
            visited[xx][yy] = true
            queue.append([xx,yy,cnt])
        }
    }
    
    return min
}

func isBound(_ x: Int, _ y: Int) -> Bool{
    return x > 0 && y > 0 && x <= a && y <= b
}

print(solution(board, a, b, start, end))
