import Foundation

let TC = Int(readLine()!)!
for _ in 0..<TC{
    let N = Int(readLine()!)!
    let list = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    var s = [0]
    var a = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    var dp = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    
    for i in 0..<N{
        a[i][i] = i
        s.append(s[i]+list[i])
    }
    for size in 1..<N{
        for start in 0..<N-size{
            let end = start+size
            dp[start][end] = Int.max
            for mid in a[start][end-1]..<[a[start+1][end]+1,end].min()!{
                let min = dp[start][mid]+dp[mid+1][end]+s[end+1]-s[start]
                if dp[start][end] > min{
                    dp[start][end] = min
                    a[start][end] = mid
                }
            }
        }
    }
    print(dp[0][N-1])
}

