import Foundation
let pisano = 1500000
var n = Int(readLine()!)!%pisano
var dp = [0,1,1]
if n < 3 { print(dp[n]) }
else{
    for i in 3...n{
        dp.append((dp[i-1]+dp[i-2])%1000000)
    }
    print(dp.last!)
}

