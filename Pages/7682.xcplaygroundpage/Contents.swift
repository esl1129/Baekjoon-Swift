import Foundation

let validArr = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
func check(_ char: String, _ line: [String]) -> Bool{
    for valid in validArr{
        if line[valid[0]] == char && line[valid[1]] == char && line[valid[2]] == char { return true}
    }
    return false
}

func ttt(_ line: [String]) -> Bool{
    let xCnt = line.filter{$0 == "X"}.count
    let oCnt = line.filter{$0 == "O"}.count
    if oCnt > xCnt || xCnt-oCnt > 1{ return false }
    let xChk = check("X", line)
    let oChk = check("O", line)
    if !xChk && !oChk && xCnt+oCnt == 9 { return true }
    if xCnt == oCnt && !xChk && oChk{ return true }
    if xCnt > oCnt && xChk && !oChk{ return true }
    return false
}

while let line = readLine(){
    if line == "end" { break }
    print(ttt(line.map{String($0)}) ? "valid" : "invalid")
}


