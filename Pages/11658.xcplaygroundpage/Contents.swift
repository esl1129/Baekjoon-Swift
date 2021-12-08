import Foundation

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let N = line[0]
let M = line[1]

var sample = [Int](repeating: 0, count: N+1)
var board = [sample]
var sumboard = [sample]

for _ in 1...N{
    let a: [Int] = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    board.append([0]+a)
    sumboard.append([0]+a)
}

for i in 1...N{
    for j in 1...N{
        sumboard[i][j] += sumboard[i-1][j]+sumboard[i][j-1]-sumboard[i-1][j-1]
    }
}

for _ in 1...M{
    let p = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    if p[0] == 0{
        let num = p[3] - board[p[1]][p[2]]
        board[p[1]][p[2]] = p[3]
        for i in p[1]...N{
            for j in p[2]...N{
                sumboard[i][j] += num
            }
        }
    }else{
        print(sumboard[p[3]][p[4]]-sumboard[p[1]-1][p[4]]-sumboard[p[3]][p[2]-1]+sumboard[p[1]-1][p[2]-1])
    }
}
