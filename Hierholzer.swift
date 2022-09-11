 func validArrangement(_ pairs: [[Int]]) -> [[Int]] {
    var graph = [Int: [Int]]()
    var degree = [Int: Int]()

    for i in pairs {
        graph[i[0], default: []].append(i[1])
        degree[i[0], default: 0] += 1
        degree[i[1], default: 0] -= 1
    }

    var start = Array(degree.keys)[0]

    for (key, value) in degree {
        if value == 1 {
            start = key
            break
        }
    }
    var ans = [[Int]]()

    func dfs(_ value: Int) {
        while !graph[value, default: []].isEmpty {
            if let child = graph[value, default: []].popLast() {
                dfs(child)
                ans.append([value, child])
            } else { break }

        }
    }

    dfs(start)
    return ans.reversed()
}
