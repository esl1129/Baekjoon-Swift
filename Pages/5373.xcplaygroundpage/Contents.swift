import Foundation

let N = Int(readLine()!)!

struct Cube{
    var up: [[String]]
    var down: [[String]]
    var north: [[String]]
    var south: [[String]]
    var east: [[String]]
    var west: [[String]]
    
    init(){
        self.up = [[String]](repeating: [String](repeating: "w", count: 3), count: 3)
        self.down = [[String]](repeating: [String](repeating: "y", count: 3), count: 3)
        self.north = [[String]](repeating: [String](repeating: "o", count: 3), count: 3)
        self.south = [[String]](repeating: [String](repeating: "r", count: 3), count: 3)
        self.east = [[String]](repeating: [String](repeating: "b", count: 3), count: 3)
        self.west = [[String]](repeating: [String](repeating: "g", count: 3), count: 3)
    }
    mutating func rotate(_ move: String){
        switch move{
        case "U+":
            up = spinRight(up)
            let row = east[0]
            east[0] = north[0]
            north[0] = west[0]
            west[0] = south[0]
            south[0] = row
        case "U-":
            up = spinLeft(up)
            let row = east[0]
            east[0] = south[0]
            south[0] = west[0]
            west[0] = north[0]
            north[0] = row
        case "D+":
            down = spinRight(down)
            let row = east[2]
            east[2] = south[2]
            south[2] = west[2]
            west[2] = north[2]
            north[2] = row
        case "D-":
            down = spinLeft(down)
            let row = east[2]
            east[2] = north[2]
            north[2] = west[2]
            west[2] = south[2]
            south[2] = row
        case "F+":
            south = spinRight(south)
            let row = up[2]
            up[2] = [west[2][2],west[1][2],west[0][2]]
            west[0][2] = down[2][2]
            west[1][2] = down[2][1]
            west[2][2] = down[2][0]
            down[2] = [east[0][0],east[1][0],east[2][0]]
            east[0][0] = row[0]
            east[1][0] = row[1]
            east[2][0] = row[2]
        case "F-":
            south = spinLeft(south)
            let row = up[2]
            up[2] = [east[0][0],east[1][0],east[2][0]]
            east[0][0] = down[2][0]
            east[1][0] = down[2][1]
            east[2][0] = down[2][2]
            down[2] = [west[2][2],west[1][2],west[0][2]]
            west[2][2] = row[0]
            west[1][2] = row[1]
            west[0][2] = row[2]
        case "B+":
            north = spinRight(north)
            let row = up[0]
            up[0] = [east[0][2],east[1][2],east[2][2]]
            east[0][2] = down[0][0]
            east[1][2] = down[0][1]
            east[2][2] = down[0][2]
            down[0] = [west[2][0],west[1][0],west[0][0]]
            west[2][0] = row[0]
            west[1][0] = row[1]
            west[0][0] = row[2]
        case "B-":
            north = spinLeft(north)
            let row = up[0]
            up[0] = [west[2][0],west[1][0],west[0][0]]
            west[0][0] = down[0][2]
            west[1][0] = down[0][1]
            west[2][0] = down[0][0]
            down[0] = [east[0][2],east[1][2],east[2][2]]
            east[0][2] = row[0]
            east[1][2] = row[1]
            east[2][2] = row[2]
        case "L+":
            west = spinRight(west)
            let row = [up[0][0],up[1][0],up[2][0]]
            up[0][0] = north[2][2]
            up[1][0] = north[1][2]
            up[2][0] = north[0][2]
            north[0][2] = down[0][2]
            north[1][2] = down[1][2]
            north[2][2] = down[2][2]
            down[0][2] = south[2][0]
            down[1][2] = south[1][0]
            down[2][2] = south[0][0]
            south[0][0] = row[0]
            south[1][0] = row[1]
            south[2][0] = row[2]
        case "L-":
            west = spinLeft(west)
            let row = [up[0][0],up[1][0],up[2][0]]
            up[0][0] = south[0][0]
            up[1][0] = south[1][0]
            up[2][0] = south[2][0]
            south[0][0] = down[2][2]
            south[1][0] = down[1][2]
            south[2][0] = down[0][2]
            down[0][2] = north[0][2]
            down[1][2] = north[1][2]
            down[2][2] = north[2][2]
            north[0][2] = row[2]
            north[1][2] = row[1]
            north[2][2] = row[0]
        case "R+":
            east = spinRight(east)
            let row = [up[0][2],up[1][2],up[2][2]]
            up[0][2] = south[0][2]
            up[1][2] = south[1][2]
            up[2][2] = south[2][2]
            south[0][2] = down[2][0]
            south[1][2] = down[1][0]
            south[2][2] = down[0][0]
            down[0][0] = north[0][0]
            down[1][0] = north[1][0]
            down[2][0] = north[2][0]
            north[0][0] = row[2]
            north[1][0] = row[1]
            north[2][0] = row[0]
        case "R-":
            east = spinLeft(east)
            let row = [up[0][2],up[1][2],up[2][2]]
            up[0][2] = north[2][0]
            up[1][2] = north[1][0]
            up[2][2] = north[0][0]
            north[0][0] = down[0][0]
            north[1][0] = down[1][0]
            north[2][0] = down[2][0]
            down[0][0] = south[2][2]
            down[1][0] = south[1][2]
            down[2][0] = south[0][2]
            south[0][2] = row[0]
            south[1][2] = row[1]
            south[2][2] = row[2]
        default:
            break
        }
    }
    func spinLeft(_ plane: [[String]]) -> [[String]]{
        var newBoard = plane
        for i in 0..<3{
            for j in 0..<3{
                newBoard[2-j][i] = plane[i][j]
            }
        }
        return newBoard
    }
    func spinRight(_ plane: [[String]]) -> [[String]]{
        var newBoard = plane
        for i in 0..<3{
            for j in 0..<3{
                newBoard[j][2-i] = plane[i][j]
            }
        }
        return newBoard
    }
}

for _ in 0..<N{
    var cube = Cube()
    _ = Int(readLine()!)!
    let moves = readLine()!.components(separatedBy: " ").map{String($0)}
    for move in moves{
        cube.rotate(move)
        
    }
    for arr in cube.up{
        print(arr.joined())
    }
}
