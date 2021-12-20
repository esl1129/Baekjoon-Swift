import Foundation

let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let min = line[0]
let max = line[1]
var values: [Bool] = Array(repeating: true, count: max-min+1)

if max >= 2 {
    for i in 2...max {
        if i * i > max {
            break
        }
        if i * i >= min {
            values[Int(i*i-min)] = false
        }
        let k = min/(i*i)
        for j in k...max {
            if i*i*j >= min && i*i*j <= max {
                values[Int(i*i*j - min)] = false
            } else if i*i*j > max{
                break
            }
        }
    }
}

print(values.filter{$0 == true}.count)
