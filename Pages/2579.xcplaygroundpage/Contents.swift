import Foundation
let n = Int(readLine()!)!
var step = [Int](repeating: Int(readLine()!)!, count: n)

func solution(_ n: Int, _ steps: [Int]) -> Int{
    var dp = [[0,steps[0],steps[0]]]

    for i in 1..<n{
        let a = dp[i-1][1]
        let b = dp[i-1][2]
        let c = dp[i-1][0]+steps[i]
        let d = dp[i-1][1]+steps[i]
        dp.append([[a,b].max()!,c,d])
    }
    return [dp.last![1],dp.last![2]].max()!
}
if n < 3{
    print(step.reduce(0, +))
}else{
    print(solution(n, step))
}


