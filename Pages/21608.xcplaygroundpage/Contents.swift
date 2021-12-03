import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]

struct Student{
    let num: Int
    let fav: [Int]
    
    init(_ num: Int, _ fav: [Int]){
        self.num = num
        self.fav = fav
    }
}
func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < N && yy < N
}
let N = Int(readLine()!)!
var board = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

var studentArr = [Student]()
for _ in 0..<N*N{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    studentArr.append(Student(line[0], Array(line[1...4])))
}

for student in studentArr{
    var favCnt = -1
    var emptyCnt = -1
    var point = [0,0]
    for x in 0..<N{
        for y in 0..<N{
            if board[x][y] != 0 { continue }
            var currentFavCnt = 0
            var currentEmptyCnt = 0
            for k in 0..<4{
                let xx = x+dx[k]
                let yy = y+dy[k]
                if isBound(xx, yy){
                    if board[xx][yy] == 0{
                        currentEmptyCnt += 1
                        continue
                    }
                    if student.fav.contains(board[xx][yy]){
                        currentFavCnt += 1
                    }
                }
            }
            if currentFavCnt > favCnt{
                favCnt = currentFavCnt
                emptyCnt = currentEmptyCnt
                point = [x,y]
            }else if currentFavCnt == favCnt && currentEmptyCnt > emptyCnt{
                emptyCnt = currentEmptyCnt
                point = [x,y]
            }
        }
    }
    board[point[0]][point[1]] = student.num
}
var answer = 0

for i in 0..<N{
    for j in 0..<N{
        var good = 0
        let favStudentArr = studentArr.filter{$0.num == board[i][j]}.first!.fav
        for k in 0..<4{
            let xx = i+dx[k]
            let yy = j+dy[k]
            if !isBound(xx, yy) { continue }
            if favStudentArr.contains(board[xx][yy]) {
                if good == 0 {
                    good = 1
                    continue
                }
                good *= 10
            }
        }
        answer += good
    }
}
print(answer)
