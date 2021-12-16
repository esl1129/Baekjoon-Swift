import Foundation

let N = Int(readLine()!)!
let A = readLine()!.components(separatedBy: " ").reversed().map{Int(String($0))!}.sorted{$0 < $1}
let B = readLine()!.components(separatedBy: " ").reversed().map{Int(String($0))!}.sorted{$0 > $1}

var s = 0
for i in 0..<N{
    s += A[i]*B[i]
}
print(s)

