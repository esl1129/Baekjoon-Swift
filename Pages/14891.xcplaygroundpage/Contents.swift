import Foundation

struct Wheel{
    var arr: [Int]
    func getWest() -> Int{
        return arr[6]
    }
    func getEast() -> Int{
        return arr[2]
    }
    func getNorth() -> Int{
        return arr[0]
    }
    mutating func rotate(_ dir: Int){
        if dir == 1{
            self.arr = Array([self.arr[7]]+self.arr[0...6])
        }else{
            self.arr = Array(self.arr[1...7]+[self.arr[0]])
        }
    }
}

func move(_ index: Int, _ dir: Int,_ visit: Set<Int>){
    if index > 1 && wheelDict[index]!.getWest() != wheelDict[index-1]!.getEast() && !visit.contains(index-1){
        move(index-1, -dir, visit.union([index-1]))
    }
    if index < 4 && wheelDict[index]!.getEast() != wheelDict[index+1]!.getWest() && !visit.contains(index+1){
        move(index+1, -dir, visit.union([index+1]))
    }
    wheelDict[index]!.rotate(dir)
    return
}

var wheelDict = [Int:Wheel]()

for i in 1...4{
    let line = readLine()!.map{Int(String($0))!}
    wheelDict[i] = Wheel(arr: line)
}

let M = Int(readLine()!)!
for _ in 0..<M{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    move(line[0],line[1],[line[0]])
}

var answer = 0
for i in 0...3{
    answer += Int(pow(2.0, Double(i)))*wheelDict[i+1]!.getNorth()
}
print(answer)
