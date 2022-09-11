
class Combinations {
    // permutation
    static func permutate(_ array: [Int], _ left: Int, _ right: Int, _ size: Int) -> [[Int]] {
        Array(Combinations.permutateHelper(array, left, right, size))
    }

    private static func permutateHelper(_ array: [Int], _ left: Int, _ right: Int, _ size: Int) -> Set<[Int]> {
        var res = Set<[Int]>()
        var array = array
        if left >= right {
            res.insert(Array(array[0..<size]))
            return
        }
        
        for i in left...right {
            array.swapAt(left, i)
            res += permutate(array, left + 1, right, size)
            array.swapAt(left, i)
        }
        
        return res
    }
  
    // n choose k
    static func combos<T>(_ elements: [T], _ k: Int) -> [[T]] {
        if k == 0 {
            return [[]]
        }

        guard let first = elements.first else {
            return []
        }

        let head = [first]
        var elements = elements
        elements.removeFirst()
        let subcombos = combos(elements, k - 1)
        var ret = subcombos.map { head + $0 }
        ret += combos(elements, k)

        return ret
    }
}
