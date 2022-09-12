class SegmentTree: CustomStringConvertible {
    private var maximum = [Int]()
    private var minimum = [Int]()
    private var array = [Int]()
    
    private init(_ array: [Int]) {
        self.array = array
        build()
    }

    class func make(_ array: [Int]) -> SegmentTree  {
        return SegmentTree(array)
    }
    
    
    private func build() {
        var tempMax = [array]
        var tempMin = [array]
        
        while let lastMax = tempMax.last, let lastMin = tempMin.last, lastMax.count > 1 {
            var currentMax = [Int]()
            var currentMin = [Int]()
            let count = lastMax.count
        
            for i in 0..<count where i % 2 == 0 {
                if i + 1 < count {
                    currentMax.append(max(lastMax[i], lastMax[i + 1]))
                    currentMin.append(min(lastMin[i], lastMin[i + 1]))
                } else {
                    currentMax.append(lastMax[i])
                    currentMin.append(lastMin[i])
                }
            }
            
            tempMax.append(currentMax)
            tempMin.append(currentMin)
        }
        
        let count = tempMax.count
        
        for i in (0..<count).reversed() {
            maximum.append(contentsOf: tempMax[i])
            minimum.append(contentsOf: tempMin[i])
        }
    }
    
    func getMin(_ start: Int, _ end: Int) -> Int {
        let count = array.count
        return getMinHelper(start, end, 0, count - 1, 0)
    }
    
    func getMinHelper(_ queryLow: Int, _ queryHigh: Int, _ low: Int, _ high: Int, _ pos: Int) -> Int {
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
    
    func getMax(_ start: Int, _ end: Int) -> Int {
        let count = array.count
        return getMaxHelper(start, end, 0, count - 1, 0)
    }
    
    func getMaxHelper(_ queryLow: Int, _ queryHigh: Int, _ low: Int, _ high: Int, _ pos: Int) -> Int {
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

    var description: String {
        return "maximum: \(maximum) \nminimum: \(minimum)"
    }
}
