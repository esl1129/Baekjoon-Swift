import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Customer{
    let startX: Int
    let startY: Int
    let endX: Int
    let endY: Int
    let distance: [[Int]]
    
    init(_ startX: Int, _ startY: Int, _ endX: Int, _ endY: Int, _ distanceArr: [[Int]]){
        self.startX = startX
        self.startY = startY
        self.endX = endX
        self.endY = endY
        self.distance = distanceArr
    }
    
    mutating func getDriverToStart(_ xx: Int, _ yy: Int) -> Int{
        return self.distance[xx][yy]
    }
    
    mutating func getStartToEnd() -> Int{
        return self.distance[endX][endY]
    }
}

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < n && yy < n
}

func BFS(_ x: Int, _ y: Int) -> [[Int]]{
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    var distanceArr = [[Int]](repeating: [Int](repeating: -1, count: n), count: n)
    visited[x][y] = true
    distanceArr[x][y] = 0
    var queue = [[x,y]]
    var depth = 1
    while !queue.isEmpty{
        for _ in 0..<queue.count{
            let point = queue.removeFirst()
            for k in 0..<4{
                let xx = point[0]+dx[k]
                let yy = point[1]+dy[k]
                if isBound(xx, yy) && !visited[xx][yy] && board[xx][yy] == 0{
                    queue.append([xx,yy])
                    distanceArr[xx][yy] = depth
                    visited[xx][yy] = true
                }
            }
        }
        depth += 1
    }
    
    return distanceArr
}

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let n = line[0]
let m = line[1]
var oil = line[2]
var board: [[Int]] = []
for _ in 0..<n{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var driver = readLine()!.components(separatedBy: " ").map{Int(String($0))!-1}
var customers = [Customer]()
for _ in 0..<m{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    customers.append(Customer(line[0]-1,line[1]-1,line[2]-1,line[3]-1,BFS(line[0]-1,line[1]-1)))
}

var sortedCustomers = customers.sorted{$0.startX < $1.startX}
var sortedCustomers2 = sortedCustomers.sorted{$0.startX <= $1.startX && $0.startY < $1.startY}

for i in 0..<m{
    var min = -1
    var index = 0
    for j in 0..<m-i{
        let distance = sortedCustomers2[j].getDriverToStart(driver[0], driver[1])
        if distance == -1 { continue }
        if distance < min || min == -1{
            min = distance
            index = j
        }
    }
    let startToEnd = sortedCustomers2[index].getStartToEnd()
    driver[0] = sortedCustomers2[index].endX
    driver[1] = sortedCustomers2[index].endY
    sortedCustomers2.remove(at: index)
    if oil < (min+startToEnd) || min == -1 || startToEnd == -1{
        oil = -1
        break
    }
    oil += (startToEnd-min)
}
print(oil)
