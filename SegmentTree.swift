class SegmentTree: CustomStringConvertible {
    private var maximum = [Int]()
    private var minimum = [Int]()
    private var lazyMaximum = [Int]()
    private var lazyMinimum = [Int]()
    private var array = [Int]()
    
    private init(_ array: [Int]) {
        self.array = array
        build()
    }

    class func make(_ array: [Int]) -> SegmentTree  {
        return SegmentTree(array)
    }
    
    
    private func build() {
        var power = 1
        let count = array.count
        while power < count {
            power *= 2
        }
        
        let len = (power * 2) - 1
        
        maximum = Array(repeating: 0, count: len)
        minimum = Array(repeating: 0, count: len)
        lazyMaximum = Array(repeating: 0, count: len)
        lazyMinimum = Array(repeating: 0, count: len)
        
        buildMaxHelper(0, count - 1, 0)
        buildMinHelper(0, count - 1, 0)
    }

    private func buildMaxHelper(_ low: Int, _ high: Int, _ pos: Int) {
        let count = maximum.count
        if pos >= count { return }
        if low == high { 
            maximum[pos] = array[low]
            return
        }
        
        let mid = (low + high) >> 1
        buildMaxHelper(low, mid, (2 * pos) + 1)
        buildMaxHelper(mid + 1, high, (2 * pos) + 2)
        
        if (2 * pos) + 1 < count {
            maximum[pos] =  maximum[(2 * pos) + 1]
        }

        if (2 * pos) + 2 < count {
            maximum[pos] =  max(maximum[pos], maximum[(2 * pos) + 1])
        }
    }
    
     private func buildMinHelper(_ low: Int, _ high: Int, _ pos: Int) {
        let count = minimum.count
        if pos >= count { return }
        if low == high { 
            minimum[pos] = array[low]
            return
        }
        
        let mid = (low + high) >> 1
        buildMinHelper(low, mid, (2 * pos) + 1)
        buildMinHelper(mid + 1, high, (2 * pos) + 2)
        
        if (2 * pos) + 1 < count {
            minimum[pos] =  minimum[(2 * pos) + 1]
        }

        if (2 * pos) + 2 < count {
            minimum[pos] =  min(minimum[pos], minimum[(2 * pos) + 1])
        }
    }

    func getMin(_ start: Int, _ end: Int) -> Int {
        let count = array.count
        return getMinHelper(start, end, 0, count - 1, 0)
    }
    
    private func getMinHelper(_ queryLow: Int, _ queryHigh: Int, _ low: Int, _ high: Int, _ pos: Int) -> Int {
        if high < queryLow || queryHigh < low || pos >= minimum.count {
            return Int.max
        }
        
        if queryLow <= low && high <= queryHigh {
            return minimum[pos]
        }

        let mid = (low + high) >> 1
        
        return min(getMinHelper(queryLow, queryHigh, low, mid, (2 * pos) + 1),
                  getMinHelper(queryLow, queryHigh, mid + 1, high, (2 * pos) + 2))
    }
    
    func incrementMin(_ start: Int, _ end: Int, _ delta: Int) {
        let count = array.count
        return incrementMinHelper(start, end, 0, count - 1, 0, delta)
    }
    
    private func incrementMinHelper(_ start: Int, _ end: Int, _ low: Int, _ high: Int, _ pos: Int, _ delta: Int) {
        let count = minimum.count
        if low > high || pos >= count { return }
        
        if lazyMinimum[pos] != 0 {
            minimum[pos] += lazyMinimum[pos]
            if low != high {
                if (2 * pos) + 1 < count {
                    lazyMinimum[(2 * pos) + 1] += lazyMinimum[pos]
                }

                if (2 * pos) + 2 < count {
                    lazyMinimum[(2 * pos) + 2] += lazyMinimum[pos]
                }
            }
            
            lazyMinimum[pos] = 0
        }
        
        if high < start || end < low {
            return
        }
    
        if start <= low && high <= end {
            minimum[pos] += delta
            if low != high {
                if (2 * pos) + 1 < count {
                    lazyMinimum[(2 * pos) + 1] += delta
                }

                if (2 * pos) + 2 < count {
                    lazyMinimum[(2 * pos) + 2] += delta
                }
            }
            return
        }
        
        let mid = (low + high) >> 1
        incrementMinHelper(start, end, low, mid, (2 * pos) + 1, delta)
        incrementMinHelper(start, end, mid + 1, high, (2 * pos) + 2, delta)
        
        if (2 * pos) + 1 < count {
            minimum[pos] = minimum[(2 * pos) + 1]
        }
        
        if (2 * pos) + 2 < count {
            minimum[pos] = min(minimum[pos], minimum[(2 * pos) + 2])
        }
    }
    
    func getMax(_ start: Int, _ end: Int) -> Int {
        let count = array.count
        return getMaxHelper(start, end, 0, count - 1, 0)
    }
    
    private func getMaxHelper(_ queryLow: Int, _ queryHigh: Int, _ low: Int, _ high: Int, _ pos: Int) -> Int {
        if high < queryLow || queryHigh < low || pos >= maximum.count {
            return Int.min
        }
        
        if queryLow <= low && high <= queryHigh {
            return maximum[pos]
        }
        
        let mid = (low + high) >> 1
        
        return max(getMaxHelper(queryLow, queryHigh, low, mid, (2 * pos) + 1),
                  getMaxHelper(queryLow, queryHigh, mid + 1, high, (2 * pos) + 2))
    }
    
    func incrementMax(_ start: Int, _ end: Int, _ delta: Int) {
        let count = array.count
        return incrementMaxHelper(start, end, 0, count - 1, 0, delta)
    }
    
    private func incrementMaxHelper(_ start: Int, _ end: Int, _ low: Int, _ high: Int, _ pos: Int, _ delta: Int) {
        let count = maximum.count
        if low > high || pos >= count { return }
        
        if lazyMaximum[pos] != 0 {
            maximum[pos] += lazyMaximum[pos]
            if low != high {
                if (2 * pos) + 1 < count {
                    lazyMaximum[(2 * pos) + 1] += lazyMaximum[pos]
                }

                if (2 * pos) + 2 < count {
                    lazyMaximum[(2 * pos) + 2] += lazyMaximum[pos]
                }
            }
            
            lazyMaximum[pos] = 0
        }
        
        if high < start || end < low {
            return
        }
    
        if start <= low && high <= end {
            maximum[pos] += delta
            if low != high {
                if (2 * pos) + 1 < count {
                    lazyMaximum[(2 * pos) + 1] += delta
                }

                if (2 * pos) + 2 < count {
                    lazyMaximum[(2 * pos) + 2] += delta
                }
            }
            return
        }
        
        let mid = (low + high) >> 1
        incrementMaxHelper(start, end, low, mid, (2 * pos) + 1, delta)
        incrementMaxHelper(start, end, mid + 1, high, (2 * pos) + 2, delta)
        
        if (2 * pos) + 1 < count {
            maximum[pos] = maximum[(2 * pos) + 1]
        }
        
        if (2 * pos) + 2 < count {
            maximum[pos] = max(maximum[pos], maximum[(2 * pos) + 2])
        }
    }

    var description: String {
        return "maximum: \(maximum) \nminimum: \(minimum)"
    }
}
