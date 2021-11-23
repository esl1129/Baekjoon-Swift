import Foundation

var line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
var n = line[0]
var k = line[0]-line[1] > line[1] ? line[1] : line[0]-line[1]

func nCr(_ n: Int, _ k: Int) -> Int{
    if n == 1 || n == k || k == 0 { return 1}
    return nCr(n-1,k)+nCr(n-1, k-1)
}
print(nCr(n, k))
