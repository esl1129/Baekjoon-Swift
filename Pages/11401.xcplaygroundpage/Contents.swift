import Foundation

var line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
var n = line[0]
var k = line[0]-line[1] > line[1] ? line[1] : line[0]-line[1]
if n == 1 || n == k || k == 0 { print(1) }
else{
    var ans = 1
    for i in n-k+1...n{
        ans *= i
        ans %= 1000000007
    }
    for j in 1...k{
        ans /= j
    }
    print(ans)
}

