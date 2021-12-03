import Foundation

var dx = [-1,-1,0,1,1,1,0,-1]
var dy = [0,1,1,1,0,-1,-1,-1]

struct Fire{
    var massSum: Int
    var speedSum: Int
    var cnt: Int
    var distance: [Int]
    
    init (_ massSum: Int, _ speedSum: Int,_ cnt: Int, _ distance: [Int]){
        self.massSum = massSum
        self.speedSum = speedSum
        self.cnt = cnt
        self.distance = distance
    }
    
    mutating func division() -> [Fire]{
        var returnArr: [Fire] = []
        let mass = self.massSum/5
        let speed = self.speedSum/cnt
        let start = (distance.filter{$0%2 == 0}.count == 0 || distance.filter{$0%2 != 0}.count == 0) ? 0 : 1
        for i in stride(from: start, to: 8, by: 2){
            returnArr.append(Fire(mass, speed, 1, [i]))
        }
        
        return returnArr
    }
}

func move(_ xx: Int, _ yy: Int, _ distance: Int, _ speed: Int) -> [Int]{
    let x = xx+dx[distance]*speed < 0 ? xx+dx[distance]*speed+N : xx+dx[distance]*speed >= N ? xx+dx[distance]*speed-N : xx+dx[distance]*speed
    let y = yy+dy[distance]*speed < 0 ? yy+dy[distance]*speed+N : yy+dy[distance]*speed >= N ? yy+dy[distance]*speed-N : yy+dy[distance]*speed
    return [x,y]
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]
let K = line[2]

var board = [[Fire]](repeating: [Fire](repeating: Fire(0, 0, 0, []), count: N), count: N)

for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let x = line[0]-1
    let y = line[1]-1
    let mass = line[2]
    let speed = line[3]
    let distance = line[4]
    board[x][y].massSum += mass
    board[x][y].speedSum += speed
    board[x][y].cnt += 1
    board[x][y].distance.append(distance)
}

for _ in 0..<K{
    var newBoard = [[Fire]](repeating: [Fire](repeating: Fire(0, 0, 0, []), count: N), count: N)
    for i in 0..<N{
        for j in 0..<N{
            if board[i][j].cnt == 0 { continue }
            var fires = board[i][j]
            if fires.cnt == 1 {
                let point = move(i, j, fires.distance.first!, fires.speedSum%N)
                newBoard[point[0]][point[1]].massSum += fires.massSum
                newBoard[point[0]][point[1]].speedSum += fires.speedSum
                newBoard[point[0]][point[1]].cnt += 1
                newBoard[point[0]][point[1]].distance.append(fires.distance.first!)
            }else if fires.massSum >= 5{
                let newFireArr = fires.division()
                for fire in newFireArr{
                    let point = move(i, j, fire.distance.first!, fire.speedSum%N)
                    newBoard[point[0]][point[1]].massSum += fire.massSum
                    newBoard[point[0]][point[1]].speedSum += fire.speedSum
                    newBoard[point[0]][point[1]].cnt += 1
                    newBoard[point[0]][point[1]].distance.append(fire.distance.first!)
                }
                
            }
        }
    }
    board = newBoard
}
var sum = 0
for i in 0..<N{
    for j in 0..<N{
        if board[i][j].cnt == 0 { continue }
        var fires = board[i][j]
        if fires.cnt == 1 {
            sum += fires.massSum
            continue
        }
        if fires.massSum >= 5{
            let newFireArr = fires.division()
            for fire in newFireArr{
                sum += fire.massSum
            }
        }
    }
}



print(sum)
