import Foundation
let n = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let row = n[0]
let col = n[1]
var arr = [[String]]()
var red = [0,0]
var blue = [0,0]
var hole = [0,0]
let dx = [-1,0,1,0]
let dy = [0,1,0,-1]
for i in 0..<row{
    var a = readLine()!.map{String($0)}
    if let redY = a.firstIndex(of: "R"){
        red = [i,redY]
        a[redY] = "."
    }
    if let blueY = a.firstIndex(of: "B"){
        blue = [i,blueY]
        a[blueY] = "."
    }
    if let holeY = a.firstIndex(of: "O"){
        hole = [i,holeY]
    }
    arr.append(a)
}
// board, n == row, m == col
func solution(_ board: [[String]], _ R: [Int], _ B: [Int], _ H: [Int]){
    print(board)
    print(R,B,H)
}


solution(arr,red,blue,hole)

func isBound(_ point: [Int]) -> Bool{
    return point[0] >= 1 && point[1] >= 1 && point[0] < row-1 && point[1] < col-1
}
