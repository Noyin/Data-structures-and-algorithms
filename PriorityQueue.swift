import Foundation

class Heap<T: Equatable>: CustomStringConvertible {
    var array: [T] = [T]()
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
        array.swapAt(0, array.count - 1)
        let last = array.removeLast()
        heapifyDown()
        return last
    }

    func heapifyUP(_ start: Int? = nil) {
        let len = array.count
        var index = len - 1
        if let start = start {
            index = start
        }

        while 0 <= index && index < len {
            let parent = index >> 1
            if parent == index { return }
            if compareCallback(array[index], array[parent]) {
                array.swapAt(parent, index)
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
        let len = array.count
        while index < len {
            var temp = index
            let left = (index * 2)
            let right = (index * 2) + 1

            if left < len {
                if compareCallback(array[left], array[temp]) {
                    temp = left
                }
            }

            if right < len {
                if compareCallback(array[right], array[temp]) {
                    temp = right
                }
            }

            if temp == index { return }
            
            if compareCallback(array[temp], array[index]) {
                array.swapAt(index, temp)
                index = temp
                continue
            }

            return 
        }
    }

    var description: String {
        return "\(array)"
    }
}

// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Heap/Heap.swift
// Written for the Swift Algorithm Club by Kevin Randrup and Matthijs Hollemans

public struct Heap<T> {
  
  var nodes = [T]()  
  private var orderCriteria: (T, T) -> Bool
  
  public init(sort: @escaping (T, T) -> Bool) { self.orderCriteria = sort }
  
  public var isEmpty: Bool { return nodes.isEmpty }
  public var count: Int { return nodes.count }

  @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int { return (i - 1) / 2 }
  @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int { return 2*i + 1 }
  @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int { return 2*i + 2 }
  
  public func peek() -> T? { return nodes.first }
  
  public mutating func insert(_ value: T) {
    nodes.append(value)
    shiftUp(nodes.count - 1)
  }
  
  @discardableResult public mutating func remove() -> T? {
    guard !nodes.isEmpty else { return nil }    
    if nodes.count == 1 {
      return nodes.removeLast()
    } else {
      let value = nodes[0]
      nodes[0] = nodes.removeLast()
      shiftDown(0)
      return value
    }
  }
  
  internal mutating func shiftUp(_ index: Int) {
    var childIndex = index
    let child = nodes[childIndex]
    var parentIndex = self.parentIndex(ofIndex: childIndex)    
    while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
      nodes[childIndex] = nodes[parentIndex]
      childIndex = parentIndex
      parentIndex = self.parentIndex(ofIndex: childIndex)
    }
    nodes[childIndex] = child
  }
  
  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
    let rightChildIndex = leftChildIndex + 1
    var first = index
    if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
      first = leftChildIndex
    }
    if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
      first = rightChildIndex
    }
    if first == index { return }    
    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
  }
  
  internal mutating func shiftDown(_ index: Int) { shiftDown(from: index, until: nodes.count) }
  
}
