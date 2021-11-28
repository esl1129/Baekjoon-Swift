import Foundation
let n = Int(readLine()!)!
var dp = [0,3,11]
if n%2 == 1 {
    print(0)
}else if n < 5{
    print(dp[n/2])
}else{
    for i in stride(from: 6, to: n+1, by: 2){
        dp.append(4*dp[i/2-1]-dp[i/2-2])
    }
    print(dp[n/2])
}
