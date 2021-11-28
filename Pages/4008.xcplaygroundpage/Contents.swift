import Foundation
let n = Int(readLine()!)!
let arr = readLine()!.components(separatedBy: " ").map{Int($0)!}
let a = arr[0]
let b = arr[1]
let c = arr[2]
let x = readLine()!.components(separatedBy: " ").map{Int($0)!}
let max = b/(a * -2)
var ans = 0
var current = 0
for i in 0..<n{
    if current+x[i] > max{
        ans += current*current*a - current*b + c
        current = x[i]
        continue
    }
    current += x[i]
}
ans += current*current*a - current*b + c

print(ans)


