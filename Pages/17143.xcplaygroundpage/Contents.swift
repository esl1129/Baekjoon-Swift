import Foundation

let dx = [0,-1,1,0,0]
let dy = [0,0,0,1,-1]
struct Shark: Hashable{
    let key: Int
    var x: Int
    var y: Int
    var dir: Int
    let size: Int
    let speed: Int
    
    mutating func move(){
        let N = dir < 3 ? (ROW-1)*2 : (COL-1)*2
        let newSpeed = speed%N
        for _ in 0..<newSpeed{
            var xx = x+dx[dir]
            var yy = y+dy[dir]
            if !isBound(xx, yy){
                dir += dir%2 == 0 ? -1 : 1
                xx = x+dx[dir]
                yy = y+dy[dir]
            }
            x = xx
            y = yy
        }
    }
}
func catchShark(_ col: Int) -> Int{
    for j in 0..<ROW{
        if board[j][col] != 0{
            let num = board[j][col]
            board[j][col] = 0
            return num
        }
    }
    return 0
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]
let M = line[2]
var sharkSet = Set<Shark>()
var board = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)
if M == 0 {
    print(0)
}else{
    for i in 1...M{
        let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
        let shark = Shark(key: i, x: line[0]-1, y: line[1]-1, dir: line[3], size: line[4], speed: line[2])
        board[shark.x][shark.y] = i
        sharkSet.insert(shark)
    }
    var answer = 0
    for state in 0..<COL{
        let num = catchShark(state)
        if num != 0 {
            let catchedShark = sharkSet.filter{$0.key == num}.first!
            let size = catchedShark.size
            answer += size
            sharkSet = sharkSet.filter{$0.key != num}
        }
        var newSharkSet = Set<Shark>()
        var newBoard = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)
        for shark in sharkSet{
            var newShark = shark
            newShark.move()
            if newBoard[newShark.x][newShark.y] == 0 {
                newBoard[newShark.x][newShark.y] = newShark.key
                newSharkSet.insert(newShark)
            }else{
                let beforeShark = newSharkSet.filter{$0.key == newBoard[newShark.x][newShark.y]}.first!
                if newShark.size > beforeShark.size{
                    newBoard[newShark.x][newShark.y] = newShark.key
                    newSharkSet = newSharkSet.filter{$0.key != beforeShark.key}
                    newSharkSet.insert(newShark)
                }
            }
        }
        sharkSet = newSharkSet
        board = newBoard
    }
    
    print(answer)
}
