import Foundation

class DSU {
    var parent: [Int]
    var rank: [Int]
    var size: Int {
        return rank.max() ?? 0
    }
    
    init(_ n: Int) {
        self.parent = Array(0..<n)
        self.rank = Array(repeating: 1, count: n)
    }
    
    func find(_ a: Int) -> Int {
        if a == parent[a] {
            return a
        }
        
        return find(parent[a])
    }
    
    func union(_ a: Int, _ b: Int) -> Bool {
        var i = find(a)
        var j = find(b)
        if i != j {
            if rank[i] < rank[j] {
                var temp = i
                i = j
                j = temp
            }
            
            parent[j] = parent[i]
            rank[j] += rank[i]
            rank[i] = rank[j]
            return true
        }
        
        return false
    }
}
