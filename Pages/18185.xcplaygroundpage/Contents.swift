import Foundation

struct CNT{
    var th: Int
    var fi: Int
    var se: Int
    init(_ three: Int, _ five: Int, _ seven: Int){
        self.th = three
        self.fi = five
        self.se = seven
    }
    func getCnt(_ total: Int) -> Int{
        return total-(th+fi+se)
    }
}
let N = Int(readLine()!)!
var noodle = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

var dp = [CNT](repeating: CNT(0, 0, 0), count: N)

var answer = 3*noodle[0]
dp[0].th = noodle[0]

for i in 0..<N-1{
    let min = dp[i].th < noodle[i+1] ? dp[i].th : noodle[i+1]
    dp[i+1].fi += min
    dp[i].fi += min
    dp[i].th -= min
    answer -= 3*min
    answer += 5*min

    if i != 0 {
        let min2 = [dp[i-1].fi,dp[i].fi,dp[i+1].getCnt(noodle[i+1])].min()!
        dp[i-1].fi -= min2
        dp[i].fi -= min2
        dp[i-1].se += min2
        dp[i].se += min2
        dp[i+1].se += min2
        answer -= 5*min2
        answer += 7*min2
    }
    dp[i+1].th += dp[i+1].getCnt(noodle[i+1])
    answer += 3*dp[i+1].th
}

print(answer)
