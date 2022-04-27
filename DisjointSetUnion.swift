struct DSU {
    var parent: [Int]
    var rank: [Int]
    var size: Int {
        return rank.max() ?? 0
    }
    
    init(_ n: Int) {
        self.parent = Array(0..<n)
        self.rank = Array(repeating: 1, count: n)
         parent = [Int](0..<n)
         rank = [Int](repeating: 0, count: n)
    }
    
    mutating func find(_ a: Int) -> Int {
        if a == parent[a] {
            return a
        }
        parent[a] = find(parent[a])
        return parent[a]
    }
    
    mutating func union(_ a: Int, _ b: Int) -> Bool {
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
