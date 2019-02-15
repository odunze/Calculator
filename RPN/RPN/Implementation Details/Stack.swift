//
//  Stack.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

internal struct Stack<T>: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = T
    
    internal init(arrayLiteral elements: ArrayLiteralElement...) {
        items = elements
    }
    
    internal init(_ initialItems: [T] = []) {
        items = initialItems
    }
    
    internal mutating func push(_ value: T) {
        items.append(value)
    }
    
    @discardableResult
    internal mutating func pop() -> T? {
        return items.popLast()
    }
    
    internal func peek(offset: Int = 0) -> T? {
        // This will not remove the top item from the stack
        var index = items.endIndex - 1
        index -= offset
        if index < items.startIndex { return nil }
        return items[index]
    }
    
    internal func first(where matches: (T) -> Bool) -> T? {
        return items.last(where: matches)
    }
    
    internal mutating func clear() {
        items.removeAll()
    }
    
    internal private(set) var items: [T]
}
