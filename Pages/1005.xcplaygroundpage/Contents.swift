import Foundation
final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        
        return buffer[index]
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    @inline(__always) func readString() -> String {
        var now = read()
        
        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1
        
        while now != 10,
              now != 32,
              now != 0 { now = read() }
        
        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }
    
    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()
        
        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1
        
        while now != 10,
              now != 32,
              now != 0 { now = read() }
        
        return Array(buffer[beginIndex..<(index-1)])
    }
}

let fIO = FileIO()

func solution() -> Int{
    func DFS(_ n: Int){
        var max = 0
        if edges[n] == nil{
            dp[n] = price[n]
            return
        }
        for edge in edges[n]!{
            if dp[edge] == -1{
                DFS(edge)
            }
            max = max > dp[edge] ? max : dp[edge]
        }
        dp[n] = price[n]+max
        return
    }
    let N = fIO.readInt()
    let K = fIO.readInt()
    var edges: [Int: [Int]] = [:]
    var price: [Int] = [0]
    var dp = [Int](repeating: -1, count: N+1)
    for _ in 0..<N{
        price.append(fIO.readInt())
    }
    for _ in 0..<K{
        let child = fIO.readInt()
        let parent = fIO.readInt()
        if edges[parent] == nil{
            edges[parent] = [child]
        }else{
            edges[parent]!.append(child)
        }
    }
    let start = fIO.readInt()
    DFS(start)
    return dp[start]
}
for _ in 0..<fIO.readInt(){
    print(solution())
}
