import Foundation

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let arr = readLine()!.components(separatedBy: " ").map{Int(String($0))!}.filter{$0 < line[1]}
print(arr.map{String($0)}.joined(separator: " "))
