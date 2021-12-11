import Foundation

let line = Int(readLine()!)!
let arr = readLine()!.components(separatedBy: " ").map{Int(String($0))!}.sorted{$0 < $1}
print("\(arr[0]) \(arr[line-1])")
