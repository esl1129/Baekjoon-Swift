import Foundation
import Darwin

struct Point{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
        self.x = x
        self.y = y
    }
}

func CCW(_ p1: Point, _ p2: Point, _ p3: Point) -> Int{
    let a = (p2.y-p1.y)*(p3.x-p1.x)
    let b = (p3.y-p1.y)*(p2.x-p1.x)
    return a > b ? -1 : 1
}

func check(_ p1: Point,_ p2: Point,_ p3: Point,_ p4: Point) -> Bool{
    return p1 == p2 || p1 == p3 || p1 == p4 || p2 == p3 || p2 == p4 || p3 == p4
}

let line1 = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let p1 = Point(line1[0], line1[1])
let p2 = Point(line1[2], line1[3])
let line2 = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let p3 = Point(line2[0], line2[1])
let p4 = Point(line2[2], line2[3])

let a = CCW(p1, p2, p3)*CCW(p1, p2, p4)
let b = CCW(p3, p4, p1)*CCW(p3, p4, p2)

let answer = a < 0 && b < 0 ? 1 : 0

if check
print(answer)
