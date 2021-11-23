import Foundation

var n = Int(readLine()!)!

var ans = 0
let line = readLine()!.components(separatedBy: " ").map{Int($0)!}
let b = readLine()!.components(separatedBy: " ").map{Int($0)!}

for l in line{
    ans += l-b[0] < 0 ? 1 : (l-b[0])%b[1] == 0 ? (l-b[0])/b[1] : (l-b[0])/b[1]+1
}
print(ans)
