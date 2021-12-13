import Foundation

let TC = Int(readLine()!)!
for _ in 0..<TC{
    var visited : Set<Int> = []
    var dict : [Int:[[Int]]] = [:]
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let N = line[0]
    let D = line[1]
    var start = line[2]
    var visitPrice = [Int](repeating: Int.max, count: N+1)
    visitPrice[start] = 0
    for _ in 0..<D{
        let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
        if dict[line[1]] == nil{
            dict[line[1]] = [[line[0],line[2]]]
        }else{
            dict[line[1]]!.append([line[0],line[2]])
        }
    }
    var cnt = 0
    var answer = 0
    var price = 0
    while start != -1{
        cnt += 1
        answer = answer > price ? answer : price
        visited.insert(start)
        if dict[start] != nil{
            for p in dict[start]!{
                if visited.contains(p[0]){ continue }
                if p[1]+visitPrice[start] < visitPrice[p[0]]{
                    visitPrice[p[0]] = p[1]+visitPrice[start]
                }
            }
        }
        start = -1
        price = Int.max
        for i in 1...N {
            if visited.contains(i) { continue }
            if visitPrice[i] < price{
                start = i
                price = visitPrice[i]
            }
        }
    }
    print("\(cnt) \(answer)")
}
