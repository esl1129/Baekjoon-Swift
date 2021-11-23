import Foundation

var n = Int(readLine()!)!
var dp = [Int](repeating: 0, count: n)
for i in 0..<n{
    let line = readLine()!.components(separatedBy: " ").map{Int($0)!}
    if i+line[0] > n { continue }
    for j in i+line[0]-1..<n{
        let a = i == 0 ? line[1] : dp[i-1]+line[1]
        dp[j] = dp[j] > a ? dp[j] : a
    }
}
print(dp.last!)
