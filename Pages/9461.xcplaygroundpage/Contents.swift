import Foundation

let n = Int(readLine()!)!
var dp = [0,1,1,1]
for i in 3...100{
    dp.append(dp[i-1]+dp[i-2])
}
for _ in 0..<n{
    print(dp[Int(readLine()!)!])
}
