import Foundation

func g(_ num: Int) -> Int{
    var cnt = 0
    for i in 0..<N{
        let max = num < finish[i] ? num : finish[i]
        if max < start[i] { continue }
        cnt += ((max - start[i]) / d[i])+1
    }
    return cnt
}

let N = Int(readLine()!)!

var start = [Int](repeating: 0, count: N)
var finish = [Int](repeating: 0, count: N)
var d = [Int](repeating: 0, count: N)

for i in 0..<N{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    start[i] = line[0]
    finish[i] = line[1]
    d[i] = line[2]
}

var prev = 1
var next = 2147483647
var res = 0
while prev <= next{
    let mid = (prev+next)/2
    if g(mid)%2 == 1{
        next = mid-1
        res = mid
        continue
    }
    prev = mid+1
}

if res == 0{
    print("NOTHING")
}else{
    print("\(res) \(g(res)-g(res-1))")
}
