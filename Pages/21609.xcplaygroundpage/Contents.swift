import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]

struct Point: Hashable{
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

struct Block{
    let represent: Point
    let cnt: Int
    let rainbowCnt: Int
    let pointArr: Set<Point>
    
    init(_ represent: Point, _ cnt: Int,_ rainbowCnt: Int, _ pointArr: Set<Point>){
        self.represent = represent
        self.cnt = cnt
        self.rainbowCnt = rainbowCnt
        self.pointArr = pointArr
    }
}
let emptyNum = -3
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

let N = line[0]
let M = line[1]
var board: [[Int]] = []
for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}

func getMaxBlock(_ blockArr: [Block]) -> Block{
    let filter1 = blockArr.filter{$0.cnt == blockArr.map{$0.cnt}.max()!}
    let filter2 = filter1.filter{$0.rainbowCnt == filter1.map{$0.rainbowCnt}.max()!}
    let filter3 = filter2.filter{$0.represent.x == filter2.map{$0.represent.x}.max()!}
    let filter4 = filter3.filter{$0.represent.y == filter3.map{$0.represent.y}.max()!}

    return filter4.first!
}
func BFS() -> [Block]{
    var blockArr = [Block]()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    var queue: [Point] = []
    for i in 0..<N{
        for j in 0..<N{
            if visited[i][j] || board[i][j] == 0 || board[i][j] == -1 || board[i][j] == emptyNum { continue }
            let represent = Point(i,j)
            var pointSet: Set<Point> = [represent]
            var rainbowPointSet = Set<Point>()
            queue = [represent]
            visited[i][j] = true
            var cnt = 1
            var rainbowCnt = 0
            let representColor = board[i][j]
            while !queue.isEmpty{
                let p = queue.removeFirst()
                for k in 0..<4{
                    let xx = p.x+dx[k]
                    let yy = p.y+dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] == -1 || board[xx][yy] == emptyNum { continue }
                    if board[xx][yy] != 0 && board[xx][yy] != representColor { continue }
                    visited[xx][yy] = true
                    let newP = Point(xx,yy)
                    cnt += 1
                    if board[xx][yy] == 0 {
                        rainbowPointSet.insert(newP)
                        rainbowCnt += 1
                    }
                    queue.append(newP)
                    pointSet.insert(newP)
                }
            }
            if cnt > 1 && cnt > rainbowCnt{
                blockArr.append(Block(represent, cnt, rainbowCnt, pointSet))
            }
            for rainbowPoint in rainbowPointSet {
                visited[rainbowPoint.x][rainbowPoint.y] = false
            }
        }
    }
    return blockArr
}

func gravity(){
    for col in 0..<N{
        var next = N-1
        var prev = N
        while next >= 0{
            if board[next][col] == emptyNum{
                next -= 1
                continue
            }
            if board[next][col] == -1{
                prev = next
                next -= 1
                continue
            }
            board[prev-1][col] = board[next][col]
            if prev-1 != next{
                board[next][col] = emptyNum
            }
            prev -= 1
            next -= 1
        }
    }
}

func rotate(){
    var newBoard = board
    for i in 0..<N{
        for j in 0..<N{
            newBoard[N-j-1][i] = board[i][j]
        }
    }
    board = newBoard
}

func solution() -> Int{
    var answer = 0
    while true{
        let blockArr = BFS()
        if blockArr.isEmpty{ break }
        let maxBlock = getMaxBlock(blockArr)
        answer += maxBlock.cnt*maxBlock.cnt
        for point in maxBlock.pointArr{
            board[point.x][point.y] = emptyNum
        }
        gravity()
        rotate()
        gravity()
    }
    return answer
}

print(solution())
