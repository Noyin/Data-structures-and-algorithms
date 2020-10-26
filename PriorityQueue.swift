import Foundation

class Heap<T: Hashable & Equatable> {
    var array: [T] = [T]()
    var map = [T: Set<Int>]()
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
                if compareCallback(array[left], array[temp]) {
                    temp = left
                }
            }

            if right < array.count {
                if compareCallback(array[right], array[temp]) {
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
        var last = 0
        for index in map[object] ?? [] {
            swapAt(index, array.count - 1)
            removeLast()
            last = index

        }

        heapifyUP(last)
        heapifyDown(last)
    }

    func swapAt(_ first: Int, _ second: Int) {
        if map[array[first]] == nil { map[array[first]] = [] }
        if map[array[second]] == nil { map[array[second]] = [] }
        map[array[first]]?.remove(first)
        map[array[second]]?.remove(second)
        map[array[first]]?.insert(second)
        map[array[second]]?.insert(first)
        array.swapAt(first, second)
    }

    func removeLast() -> T? {
        let index = array.count - 1
        map[array[index]]?.remove(index)
        if !array.isEmpty { return array.removeLast() }
        return nil
    }
}

