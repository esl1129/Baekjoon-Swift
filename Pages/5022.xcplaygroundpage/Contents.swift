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

func isBound(_ xx: Int, _ yy: Int, _ ROW: Int, _ COL: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
}
func find(_ p: [Point], _ ROW: Int, _ COL: Int) -> (num: Int,arr: [Point], visited: [[Bool]]){
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    var a = 0
    a += p[0].x >= [p[2],p[3]].map{$0.x}.min()! && p[0].x >= [p[2],p[3]].map{$0.x}.max()! && p[0].y >= [p[2],p[3]].map{$0.y}.min()! && p[0].y >= [p[2],p[3]].map{$0.y}.max()! ? 1 : 0
    a += p[1].x >= [p[2],p[3]].map{$0.x}.min()! && p[1].x >= [p[2],p[3]].map{$0.x}.max()! && p[1].y >= [p[2],p[3]].map{$0.y}.min()! && p[1].y >= [p[2],p[3]].map{$0.y}.max()! ? 1 : 0
    var b = 0
    b += p[2].x >= [p[0],p[1]].map{$0.x}.min()! && p[2].x >= [p[0],p[1]].map{$0.x}.max()! && p[2].y >= [p[0],p[1]].map{$0.y}.min()! && p[2].y >= [p[0],p[1]].map{$0.y}.max()! ? 1 : 0
    b += p[3].x >= [p[0],p[1]].map{$0.x}.min()! && p[3].x >= [p[0],p[1]].map{$0.x}.max()! && p[3].y >= [p[0],p[1]].map{$0.y}.min()! && p[3].y >= [p[0],p[1]].map{$0.y}.max()! ? 1 : 0
    
    let min = a < b ? [p[2],p[3]] : [p[0],p[1]]
    let max = a < b ? [p[0],p[1]] : [p[2],p[3]]

    for i in min.map{$0.x}.min()!...min.map{$0.x}.max()!{
        for j in min.map{$0.y}.min()!...min.map{$0.y}.max()!{
            visited[i][j] = true
        }
    }
    return (abs(min[0].x-min[1].x)+abs(min[0].y-min[1].y),max,visited)
}
func solution() -> String{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]+1
    let COL = line[1]+1

    var pointArr = [Point]()
    for _ in 0..<4{
        let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
        pointArr.append(Point(line[0], line[1]))
    }
    let f = find(pointArr, ROW, COL)
    var answer = f.num
    var visited = f.visited
    let arr = f.arr
    let start = arr[0]
    let end = arr[1]
    var queue = [start]
    
    while !queue.isEmpty{
        answer += 1
        for _ in queue.indices{
            let a = queue.removeFirst()
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy, ROW, COL) || visited[xx][yy] { continue }
                let p1 = Point(xx, yy)
                if p1 == end { return String(answer) }
                visited[xx][yy] = true
                queue.append(p1)
            }
        }
    }
    return "IMPOSSIBLE"
}

print(solution())
