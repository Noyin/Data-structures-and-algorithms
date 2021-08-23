class FloydWarshall {
  // properties
  
  var dp: [[Int]]
  var graph: [[Int]]
 
  // init
  
  init(number: Int, graph: [[Int]]) {
    dp = Array(repeating: Array(repeating: 1000000007, count: n + 1), count: n + 1)
    self.graph = graph
  }
  
  // methods
  
  func calculateASP() {
    for i in graph {
        dp[i[0]][i[1]] = i[2]
        dp[i[1]][i[0]] = i[2]
    }
    
    for k in 0..<n {
        for i in 0..<n {
            for j in 0..<n {
                if i == j {
                   dp[i][j] = 0 
                } else {
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j])
                }
            }
        }
    }
  }    
}
