import Foundation

let N = Int(readLine()!)!
var board = [[Int]]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var min = Int.max
func makeTeam(_ team: [Int], _ index: Int){
    if team.count == N/2{
        let now = competition(team)
        min = min < now ? min : now
        return
    }
    for i in index..<N{
        makeTeam(team+[i], i+1)
    }
    return
}

func competition(_ team: [Int]) -> Int{
    var opposite = [Int]()
    for i in 0..<N{
        if !team.contains(i){
            opposite.append(i)
        }
    }
    var score = 0
    var oppositeScore = 0
    for i in 0..<N/2{
        for j in 0..<N/2{
            if i == j { continue }
            score += board[team[i]][team[j]]
        }
    }
    for i in 0..<N/2{
        for j in 0..<N/2{
            if i == j { continue }
            oppositeScore += board[opposite[i]][opposite[j]]
        }
    }
    return abs(score-oppositeScore)
}

for i in 0..<N/2{
    makeTeam([i], i+1)
}

print(min)
