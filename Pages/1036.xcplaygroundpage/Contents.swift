import Foundation

let ts = ["0":0, "1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"A":10,"B":11,"C":12,"D":13,"E":14,"F":15,"G":16,"H":17,"I":18,"J":19,"K":20,"L":21,"M":22,"N":23,"O":24,"P":25,"Q":26,"R":27,"S":28,"T":29,"U":30,"V":31,"W":32,"X":33,"Y":34,"Z":35]
let N = Int(readLine()!)!
var strArr = [[String]]()
var max = 0
for _ in 0..<N{
    let st = readLine()!.reversed().map{String($0)}
    let cnt = st.count
    max = max > cnt ? max : cnt
    strArr.append(st)
}

let K = Int(readLine()!)!
var stSet = Set<String>()
func make(){
    while true{
        for i in stride(from: max-1, to: -1, by: -1){
            var stDict = [String:Int]()
            for str in strArr{
                if str.count <= i { continue }
                if stDict[str[i]] == nil{
                    stDict[str[i]] = 1
                }else{
                    stDict[str[i]]! += 1
                }
            }
            if stDict.isEmpty { continue }
            for (key,_) in stDict.sorted{$0.value < $1.value}.sorted{$0.value <= $1.value && $0.key < $1.key}{
                stSet.insert(key)
                if stSet.count == K { return }
            }
        }
    }
}

make()
var answer = ""
var num = 0
for i in 0..<max{
    for str in strArr{
        if str.count <= i { continue }
        if stSet.contains(str[i]) {
            num += 35
        }else{
            num += ts[str[i]]!
        }
    }
    answer += ts.filter{$0.value == num%36}.first!.key
    num /= 36
}

while num != 0{
    answer += ts.filter{$0.value == num%36}.first!.key
    num /= 36
}

print(String(answer.reversed()))
