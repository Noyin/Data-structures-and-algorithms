class SegmentTree<T> {
    private var maximum = [T]()
    private var minimum = [T]()
    private var array = [T]()
    
    private init(_ array: [T]) {
        self.array = array         
        build()
    }

    class func make(_ array: [T]) -> SegmentTree  {
        return SegmentTree(array)
    }
    
    
    private func build() {
        var tempMax = [array]
        var tempMin = [array]
        
        while let lastMax = tempMax.last, let lastMin = tempMin.last, lastMax.count > 1 {
            var currentMax = [T]()
            var currentMin = [T]()
            let count = last.count
        
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
            maximuma.append(contentOf: tempMax[i])
            minimum.append(contentOf: tempMin[i])
        }
    }
    
    func getMin(_ start: Int, _ end: Int) -> T {
        
    }
    
    func getMax(_ start: Int, _ end: Int) -> T {
        
    }
}
