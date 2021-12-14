import Foundation

struct edge{
    let p: Int
    var time: Int
}
let TC = Int(readLine()!)!
let INF = Int.max
for _ in 0..<TC{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let N = line[0]
    let D = line[1]
    let start = line[2]
    var visitPrice = [Int](repeating: INF, count: N+1)
    var edgeDict = [Int:[edge]]()
    for _ in 0..<D{
        let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
        if edgeDict[line[1]] == nil{
            edgeDict[line[1]] = [edge(p: line[0], time: line[2])]
        }else{
            edgeDict[line[1]]!.append(edge(p: line[0], time: line[2]))
        }
    }
    var queue = [edge(p: start, time: 0)]
    var max = 1
    var index = 0
    while index < max{
        if queue[index].time < visitPrice[queue[index].p]{
            visitPrice[queue[index].p] = queue[index].time
            if edgeDict[queue[index].p] != nil{
                for ed in edgeDict[queue[index].p]!{
                    if ed.time+queue[index].time > visitPrice[ed.p] { continue }
                    queue.append(edge(p: ed.p, time: ed.time+queue[index].time))
                    max += 1
                }
            }
        }
        index += 1
    }
    visitPrice = visitPrice.filter{$0 != INF}
    print("\(visitPrice.count) \(visitPrice.max()!)")
}
