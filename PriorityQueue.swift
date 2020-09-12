import Foundation

class Heap<T: Hashable & Equatable> {
    var array: [T] = [T]()
    var map = [T: Int]()
    var compareCallback: (T, T) -> Bool
    var top: T? {
        return array.first
    }

    init(_ compareCallback: @escaping (T, T) -> Bool) {
        self.compareCallback = compareCallback
    }

    func enqueue(_ element: T) {
       array.append(element)
       heapifyUP()
    }

    func dequeue() -> T? {
        if array.isEmpty { return nil }
        swapAt(0, array.count - 1)
        let last = removeLast()
        heapifyDown()
        return last
    }

    func heapifyUP(_ start: Int? = nil) {
        var index = array.count - 1
        if let start = start {
            index = start
        }

        while 0 <= index && index < array.count {
            let parent = index >> 1
            if parent == index { return }
            if compareCallback(array[parent], array[index]) {
                swapAt(parent, index)
                index = parent
                continue
            }

            return 
        }
    }

    func heapifyDown(_ start: Int? = nil) {
        var index = 0
        if let start = start {
            index = start
        }
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
                swapAt(index, temp)
                index = temp
                continue
            }

            return 
        }
    }

    func remove(_ object: T) {
        guard let index = map[object] else { return }
        swapAt(index, array.count - 1)
        removeLast()
        heapifyUP(index)
        heapifyDown(index)
    }

    func swapAt(_ first: Int, _ second: Int) {
        map[array[first]] = second
        map[array[second]] = first
        array.swapAt(first, second)
    }

    func removeLast() -> T? {
        let index = array.count - 1
        map[array[index]] = nil
        return array.removeLast()
    }
}
