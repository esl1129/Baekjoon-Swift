import Foundation

let dr = [1,-1,0,0,1,-1,1,-1]
let dc = [0,0,-1,1,1,1,-1,-1]

let dirDict = ["R":0,"L":1,"B":2,"T":3,"RT": 4,"LT":5,"RB":6,"LB":7]
let strToInt = ["A":1,"B":2,"C":3,"D":4,"E":5,"F":6,"G":7,"H":8]
let intToStr = [1: "A",2:"B",3:"C",4:"D",5:"E",6:"F",7:"G",8:"H"]
let l = readLine()!.components(separatedBy: " ").map{String($0)}
let kl = l[0].map{String($0)}
let sl = l[1].map{String($0)}12
let M = Int(l[2])!

func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx > 0 && yy > 0 && xx < 9 && yy < 9
}

struct Point: Hashable{
    var x: Int
    var y: Int
    
    mutating func move(_ dir: Int) -> Bool{
        let xx = self.x+dr[dir]
        let yy = self.y+dc[dir]
        if isBound(xx, yy){
            self.x = xx
            self.y = yy
            return true
        }
        return false
    }
}

var king = Point(x: strToInt[kl[0]]!, y: Int(kl[1])!)
var stone = Point(x: strToInt[sl[0]]!, y: Int(sl[1])!)

for _ in 0..<M{
    let dir = dirDict[readLine()!]!
    if Point(x: king.x+dr[dir], y: king.y+dc[dir]) == stone{
        if stone.move(dir){
            _ = king.move(dir)
        }
        continue
    }
    _ = king.move(dir)
}

print("\(intToStr[king.x]!)\(king.y)")
print("\(intToStr[stone.x]!)\(stone.y)")
