import Foundation

let dx = [1,0,1]
let dy = [0,1,1]
func isBound(_ pp: Int) -> Bool{
    return pp >= 0 && pp < N
}

enum dir: Int{
    case hor = 0, ver = 1, dia = 2
}
struct Pipe{
    let startX: Int
    let startY: Int
    let endX: Int
    let endY: Int
    let dir: dir
    func getHorizon() -> Pipe{
        return Pipe(startX: endX, startY: endY, endX: endX, endY: endY+1, dir: .hor)
    }
    func getVertical() -> Pipe{
        return Pipe(startX: endX, startY: endY, endX: endX+1, endY: endY, dir: .ver)
    }
    func getDiagnal() -> Pipe{
        return Pipe(startX: endX, startY: endY, endX: endX+1, endY: endY+1, dir: .dia)
    }
}
let N = Int(readLine()!)!
var board = [[Int]]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
var answer = 0
let start = Pipe(startX: 0, startY: 0, endX: 0, endY: 1, dir: .hor)
var queue = [start]
while !queue.isEmpty{
    let a = queue.removeFirst()
    if isBound(a.endY+1) && isBound(a.endX+1) && board[a.endX][a.endY+1] != 1 && board[a.endX+1][a.endY] != 1 && board[a.endX+1][a.endY+1] != 1{
        let pipe = a.getDiagnal()
        if pipe.endX == N-1 && pipe.endY == N-1 {
            answer += 1
        }else{
            queue.append(pipe)
        }
    }
    switch a.dir{
    case .hor:
        if isBound(a.endY+1) && board[a.endX][a.endY+1] != 1 {
            let pipe = a.getHorizon()
            if pipe.endX == N-1 && pipe.endY == N-1 {
                answer += 1
                break
            }
            queue.append(pipe)
        }
    case .ver:
        if isBound(a.endX+1) && board[a.endX+1][a.endY] != 1 {
            let pipe = a.getVertical()
            if pipe.endX == N-1 && pipe.endY == N-1 {
                answer += 1
                break
            }
            queue.append(pipe)
        }
    case .dia:
        if isBound(a.endY+1) && board[a.endX][a.endY+1] != 1 {
            let pipe = a.getHorizon()
            if pipe.endX == N-1 && pipe.endY == N-1 {
                answer += 1
            }else{
                queue.append(pipe)
            }
        }
        if isBound(a.endX+1) && board[a.endX+1][a.endY] != 1 {
            let pipe = a.getVertical()
            if pipe.endX == N-1 && pipe.endY == N-1 {
                answer += 1
            }else{
                queue.append(pipe)
            }
        }
    }
}
print(answer)
