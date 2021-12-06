import Foundation

struct Point{
    var x: Int
    var y: Int
    init(){
        self.x = 0
        self.y = 0
    }
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
}
let dx = [-1,1,0,0]
let dy = [0,0,1,-1]
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]

var board = [[String]]()
for _ in 0..<ROW{
    board.append(readLine()!.map{String($0)})
}

func incline(_ board: [[String]], _ dir: Int, _ visited: [[Bool]]) -> (newBoard: [[String]], visited: [[Bool]]){
    var newVisited = visited
    var newBoard = board

    func moveBlue() -> Bool{
        while true{
            let xx = blue.x+dx[dir]
            let yy = blue.y+dy[dir]
            if newBoard[xx][yy] == "O" {
                newBoard[blue.x][blue.y] = "."
                return false
            }
            if newBoard[xx][yy] != "." || visited[xx][yy] { return true}
            newBoard[xx][yy] = "B"
            newBoard[blue.x][blue.y] = "."
            newVisited[blue.x][blue.y] = true

            blue.x = xx
            blue.y = yy
        }
    }
    func moveRed() -> Bool{
        while true{
            let xx = red.x+dx[dir]
            let yy = red.y+dy[dir]
            if newBoard[xx][yy] == "O" {
                newBoard[red.x][red.y] = "."
                return false
            }
            if newBoard[xx][yy] != "." || visited[xx][yy] { return true}
            newBoard[xx][yy] = "R"
            newBoard[red.x][red.y] = "."
            newVisited[red.x][red.y] = true
            red.x = xx
            red.y = yy
        }
    }
    var red = Point()
    var blue = Point()
    for i in 1..<ROW-1{
        for j in 1..<COL-1{
            if newBoard[i][j] == "R" {
                red.x = i
                red.y = j
            }
            if newBoard[i][j] == "B" {
                blue.x = i
                blue.y = j
                
            }
        }
    }
    if !moveRed(){ return (newBoard, newVisited) }
    if !moveBlue(){ return (newBoard, newVisited) }
    if !moveRed(){ return (newBoard, newVisited) }
    if !moveBlue(){ return (newBoard, newVisited) }
    return (newBoard, newVisited)
}
func solution(_ board: [[String]]) -> Int{
    var min = 11
    let visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    for i in 0..<4{
        let now = moveBoard(board, 1, i, visited)
        min = min < now ? min : now
    }
    return min > 10 ? -1 : min
}

func moveBoard(_ board:[[String]], _ depth: Int, _ dir: Int, _ visited: [[Bool]]) -> Int{
    if depth > 10{
        return depth
    }
    let inclineReturn = incline(board,dir,visited)
    let newBoard = inclineReturn.newBoard
    let newVisited = inclineReturn.visited
    var min = 11
    if !newBoard.flatMap({$0}).contains("R"){
        return depth
    }
    if !newBoard.flatMap({$0}).contains("B"){
        return 11
    }
    for i in 0..<4{
        let now = moveBoard(newBoard, depth+1, i, newVisited)
        min = min < now ? min : now
    }
    return min
}

print(solution(board))
