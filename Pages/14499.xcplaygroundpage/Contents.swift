import Foundation

let dx = [0,0,0,-1,1]
let dy = [0,1,-1,0,0]
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]
let s = [line[2],line[3]]
var board: [[Int]] = []
for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}
var m = readLine()!.components(separatedBy: " ").map{Int(String($0))!}


struct Dice{
    var up: Int = 0
    var down: Int = 0
    var north: Int = 0
    var south: Int = 0
    var west: Int = 0
    var east: Int = 0
    
    mutating func rotate(_ dir: Int){
        let temp = self.up
        // 1 -> right, 2 -> left, 3 -> up, 4 -> down
        switch dir{
        case 1:
            self.up = self.west
            self.west = self.down
            self.down = self.east
            self.east = temp
        case 2:
            self.up = self.east
            self.east = self.down
            self.down = self.west
            self.west = temp
        case 3:
            self.up = self.south
            self.south = self.down
            self.down = self.north
            self.north = temp
        case 4:
            self.up = self.north
            self.north = self.down
            self.down = self.south
            self.south = temp
        default:
            break
        }
    }
}
func solution(_ moves: [Int], _ start: [Int]){
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    var point = start
    var dice = Dice()
    for move in moves {
        let xx = point[0]+dx[move]
        let yy = point[1]+dy[move]
        if !isBound(xx, yy) { continue }
        dice.rotate(move)
        if board[xx][yy] == 0{
            board[xx][yy] = dice.down
        }else{
            dice.down = board[xx][yy]
            board[xx][yy] = 0
        }
        print(dice.up)
        point = [xx,yy]
    }
}

solution(m,s)
