import Foundation

var line: [Int] = []
var N = 0
var M = 0
var price: [Int] = []
var edges: [Int: [Int]] = [:]
var dp: [Int:Int] = [:]
func solution(_ start: Int){
    func DFS(_ start: Int){
        if edges[start] == nil {
            dp[start] = price[start]
            return
        }
        for edge in edges[start]!{
            if dp[edge] == nil {
                DFS(edge)
            }
            if dp[start] == nil{
                dp[start] = dp[edge]!+price[start]
            }else if dp[edge]!+price[start] > dp[start]!{
                dp[start] = dp[edge]!+price[start]
            }
        }
        return
    }
    DFS(start)
    print(dp[start]!)
}

let TC = Int(readLine()!)!
for _ in 0..<TC{
    line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    N = line[0]
    M = line[1]
    price = [0]+readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    for _ in 0..<M{
        let l = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
        if edges[l[1]] == nil{
            edges[l[1]] = [l[0]]
        }else{
            edges[l[1]]!.append(l[0])
        }
    }
    let start = Int(readLine()!)!
    solution(start)
    edges = [:]
    dp = [:]
}

