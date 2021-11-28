import Foundation

let TC = Int(readLine()!)!

for _ in 0..<TC{
    let a = readLine()!.components(separatedBy: " ").map{Int($0)!}
    let n = a[0]
    let nC3 = a[0]*(a[0]-1)*(a[0]-2)/6
    let m = a[1]
    var arr = [Int](repeating: 0, count: n+1)
    for _ in 0..<m{
        let line = readLine()!.components(separatedBy: " ").map{Int($0)!}
        arr[line[0]] += 1
        arr[line[1]] += 1
        arr[line[2]] += 1
    }
    print(arr.filter{$0 >= nC3}.isEmpty ? "TAK" : "NIE")
}
