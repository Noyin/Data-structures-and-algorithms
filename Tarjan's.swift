func criticalConnections(_ n: Int, _ connections: [[Int]]) -> [[Int]] {
    var graph = [Int: Set<Int>]()
    var common = [Int: Set<Int>]()
    for i in connections {
        graph[i[0], default: []].insert(i[1])
        graph[i[1], default: []].insert(i[0])
    }

    var stack = [Int]()
    var low = Array(repeating: 0, count: n)
    var ids = Array(repeating: -1, count: n)
    var onStack = [Bool](repeating: false, count: n)
    var id = 0

    func dfs(_ at: Int) {
        ids[at] = id
        low[at] = id
        id += 1

        stack.append(at)
        onStack[at] = true

        for to in graph[at, default: []] {
            graph[to]?.remove(at)
            if ids[to] == -1 { dfs(to) }
            if onStack[to] { low[at] = min(low[to], low[at] ) }

        }

        if ids[at] == low[at] {
            while let to = stack.last {
                stack.removeLast()
                onStack[to] = false
                low[to] = ids[at]
                common[to, default: []].insert(at)
                common[at, default: []].insert(to) 
                if to == at { break }
            }
        }
    }

    for i in 0..<n {
        if ids[i] == -1 {
            dfs(i)
        }
    }

    var res = [[Int]]()

    for i in connections {
        if common[i[0], default: []].intersection(common[i[1], default: []]).count == 0 {
            res.append(i)
        }
    }

    return res
}
