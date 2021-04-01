        func topologocalSort() -> [Int] {
            guard !prerequisites.isEmpty else { return [] }
            var graph = [Int: [Int]]()
            var indegree = Array(repeating: 0, count: numCourses)
       
            for i in prerequisites {
                graph[i[0], default: []].append(i[1])
                indegree[i[1]] += 1
            }

            var array = [Int]()
            var res = [Int]()
            for i in 0..<indegree.count {
                if indegree[i] == 0 {
                    array.append(i)
                }
            }

            while !array.isEmpty {
                let value = array.removeLast()
                res.append(value)
                for i in graph[value, default:[]] {
                    indegree[i] -= 1
                    if indegree[i] == 0 {
                        array.append(i)
                    } 
                }
            }

            return res
        }
