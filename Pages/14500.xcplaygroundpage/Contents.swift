import Foundation
let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let ROW = line[0]
let COL = line[1]

let PointDict = [1:[0,0],2:[0,1],3:[0,2],4:[0,3],
                 5:[1,0],6:[1,1],7:[1,2],
                 8:[2,0],9:[2,1],
                 10:[3,0]]

struct Tetromino{
    var a: [Int]
    var b: [Int]
    var c: [Int]
    var d: [Int]
    
    init(_ type: [Int]){
        self.a = PointDict[type[0]]!
        self.b = PointDict[type[1]]!
        self.c = PointDict[type[2]]!
        self.d = PointDict[type[3]]!
    }
    mutating func moveCol(){
        self.a[1] += 1
        self.b[1] += 1
        self.c[1] += 1
        self.d[1] += 1
    }
    mutating func moveRow(_ i: Int){
        self.a[0] += i
        self.b[0] += i
        self.c[0] += i
        self.d[0] += i
    }
    
    mutating func check(_ row: Int, _ col: Int) -> Bool{
        return self.a[0] >= 0 && self.b[0] >= 0 && self.c[0] >= 0 && self.d[0] >= 0 && self.a[0] < row && self.b[0] < row && self.c[0] < row && self.d[0] < row && self.a[1] >= 0 && self.b[1] >= 0 && self.c[1] >= 0 && self.d[1] >= 0 && self.a[1] < col && self.b[1] < col && self.c[1] < col && self.d[1] < col
    }
    mutating func getSum() -> Int{
        return board[a[0]][a[1]]+board[b[0]][b[1]]+board[c[0]][c[1]]+board[d[0]][d[1]]
    }
}

var board = [[Int]]()
for _ in 0..<ROW{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

var max = 0
var caseArr: [[Int]] = [[1,2,3,4],[1,5,8,10],
                        [1,2,5,6],
                        [1,5,8,9],[1,2,3,5],[1,2,6,9],[3,5,6,7],
                        [2,6,8,9],[1,5,6,7],[1,2,5,8],[1,2,3,7],
                        [1,5,6,9],[2,3,5,6],
                        [2,5,6,8],[1,2,6,7],
                        [1,2,3,6],[2,5,6,9],[2,5,6,7],[1,5,6,8]]
for type in caseArr{
    var tet = Tetromino(type)
    for i in 1...ROW{
        for _ in 0...COL{
            if tet.check(ROW, COL) {
                let a = tet.getSum()
                max = max > a ? max : a
            }
            tet.moveCol()
        }
        tet = Tetromino(type)
        tet.moveRow(i)
    }
}
print(max)
