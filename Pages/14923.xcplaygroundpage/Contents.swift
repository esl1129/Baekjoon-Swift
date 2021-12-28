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

struct DoubleStackQueue<Element> {
    private var inbox: [Element] = []
    private var outbox: [Element] = []
    
    var isEmpty: Bool{
        return inbox.isEmpty && outbox.isEmpty
    }
    
    var count: Int{
        return inbox.count + outbox.count
    }
    
    var front: Element? {
        return outbox.last ?? inbox.first
    }
    
    init() { }
    
    init(_ array: [Element]) {
        self.init()
        self.inbox = array
    }
    
    mutating func enqueue(_ n: Element) {
        inbox.append(n)
    }
    
    mutating func dequeue() -> Element {
        if outbox.isEmpty {
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.removeLast()
    }
}

extension DoubleStackQueue: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init()
        inbox = elements
    }
}

struct Point: Hashable{
    let x: Int
    let y: Int
    let cnt: Int
    init(_ x: Int, _ y: Int, _ cnt: Int){
        self.x = x
        self.y = y
        self.cnt = cnt
    }
}
let dx = [0,1,0,-1]
let dy = [1,0,-1,0]



func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    let fIO = FileIO()
    let ROW = fIO.readInt()
    let COL = fIO.readInt()
    var visited = [[[Bool]]](repeating: [[Bool]](repeating: [false, false], count: COL), count: ROW)
    let start = Point(fIO.readInt()-1, fIO.readInt()-1, 0)
    visited[start.x][start.y] = [true, true]
    let end = Point(fIO.readInt()-1, fIO.readInt()-1, 0)
    var board = [[Int]](repeating: [], count: ROW)
    for i in 0..<ROW{
        for _ in 0..<COL{
            board[i].append(fIO.readInt())
        }
    }
    var q = DoubleStackQueue<Point>()
    q.enqueue(start)
    var depth = 1
    while !q.isEmpty{
        for _ in 0..<q.count{
            let a = q.dequeue()
            for k in 0..<4{
                let xx = a.x + dx[k]
                let yy = a.y + dy[k]
                if !isBound(xx, yy){ continue }
                if board[xx][yy] == 1 && a.cnt == 1 { continue }
                let cnt = board[xx][yy]+a.cnt
                if xx == end.x && yy == end.y { return depth }
                if cnt == 0{
                    if visited[xx][yy][0] { continue }
                    visited[xx][yy] = [true,true]
                    q.enqueue(Point(xx, yy, cnt))
                }else{
                    if visited[xx][yy][1] { continue }
                    visited[xx][yy][1] = true
                    q.enqueue(Point(xx, yy, cnt))
                }
            }
        }
        depth += 1
    }
    return -1
}

print(solution())
