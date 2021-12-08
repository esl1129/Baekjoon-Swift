import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
let cctvDict = [1 : [[0],[1],[2],[3]], 2: [[0,2],[1,3]], 3: [[0,1],[1,2],[2,3],[3,0]], 4: [[0,1,2],[0,1,3],[0,2,3],[1,2,3]], 5: [[0,1,2,3]]]
struct CCTV{
    let x: Int
    let y: Int
    let dirArr: [[Int]]
    init(_ x: Int, _ y: Int, _ dirArr: [[Int]]){
        self.x = x
        self.y = y
        self.dirArr = dirArr
    }
}
func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}
func getZeroCnt(_ depth: Int, _ board: [[Int]], _ zeroCnt: Int) -> Int{
    var min = Int.max
    if depth >= cctvArr.count{
        return zeroCnt
    }
    let cctv = cctvArr[depth]
    let x = cctv.x
    let y = cctv.y
    let dirArr = cctv.dirArr
    for dir in dirArr{
        var newZeroCnt = zeroCnt
        var newBoard = board
        for k in dir{
            var xx = x
            var yy = y
            while isBound(xx, yy) && newBoard[xx][yy] != 6{
                if newBoard[xx][yy] == 0 {
                    newBoard[xx][yy] = -1
                    newZeroCnt -= 1
                }
                xx += dx[k]
                yy += dy[k]
            }
        }
        let now = getZeroCnt(depth+1,newBoard,newZeroCnt)
        min = min < now ? min : now
    }
    return min
}
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]

var board = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)

var cctvArr = [CCTV]()
var zeroCnt = 0
for i in 0..<ROW{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    for j in 0..<COL{
        if line[j] == 6 {
            board[i][j] = 6
            continue
        }
        if line[j] != 0 {
            cctvArr.append(CCTV(i, j, cctvDict[line[j]]!))
        }
        zeroCnt += 1
    }
}

print(getZeroCnt(0, board, zeroCnt))
