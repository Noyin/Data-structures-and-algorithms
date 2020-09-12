import Foundation

class Heap<T> {
    var array: [T] = [T]()
    var compareCallback: (T, T) -> Bool
    var equalCallback: (T, T) -> Bool?
    var top: T? {
        return array.first
    }

    init(_ compareCallback: @escaping (T, T) -> Bool, _ equalCallback: @escaping (T, T) -> Bool = nil) {
        self.compareCallback = compareCallback
        self.equalCallback = equalCallback
    }

    func enqueue(_ element: T) {
       array.append(element)
       heapifyUP()
    }

    func dequeue() -> T? {
        if array.isEmpty { return nil }
        array.swapAt(0, array.count - 1)
        let last = array.removeLast()
        heapifyDown()
        return last
    }

    func heapifyUP(_ start: Int? = nil) {
        var index = array.count - 1
        if let start = start {
            index = start
        }

        while 0 <= index {
            let parent = index >> 1
            if parent == index { return }
            if compareCallback(array[parent], array[index]) {
                array.swapAt(parent, index)
                index = parent
                continue
            }

            return 
        }
    }

    func heapifyDown() {
        var index = 0
        while index < array.count {
            var temp = index
            let left = index * 2
            let right = left + 1

            if left < array.count {
                if compareCallback(array[temp], array[left]) {
                    temp = left
                }
            }

            if right < array.count {
                if compareCallback(array[temp], array[right]) {
                    temp = right
                }
            }

            if temp == index { return }
            
            if compareCallback(array[index], array[temp]) {
                array.swapAt(index, temp)
                index = temp
                continue
            }

            return 
        }
    }

    func remove(_ object: T) {
        for (index, element) in array.enumerated() {
            if equalCallback(element, object) {
                array.swapAt(index, array.count - 1)
                array.removeLast()
                if !array.isEmpty { heapifyUP(index) }
                return
            }
        }
    }
}

