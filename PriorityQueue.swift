import Foundation

class Heap<T> {
    var array: [T] = [T]()
    var callback: (T, T) -> Bool
    var top: T? {
        return array.first
    }

    init(_ callback: @escaping (T, T) -> Bool) {
        self.callback = callback
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

    func heapifyUP() {
        var index = array.count - 1
        while 0 <= index {
            let parent = index >> 1
            if parent == index { return }
            if callback(array[parent], array[index]) {
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
                if callback(array[temp], array[left]) {
                    temp = left
                }
            }

            if right < array.count {
                if callback(array[temp], array[right]) {
                    temp = right
                }
            }

            if temp == index { return }
            
            if callback(array[index], array[temp]) {
                array.swapAt(index, temp)
                index = temp
                continue
            }

            return 
        }
    }
}

