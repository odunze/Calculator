//
//  PostfixCalculator.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

public struct PostfixCalculator: Calculator {
    
    private var stack: Stack<Double> = []
    private var accumulator = DigitAccumulator()
    
    public let name = "RPN"
    
    public init() { }
    
    public mutating func push(digit: Digit) throws {
        try accumulator.add(digit: digit)
    }
    
    public mutating func go() {
        if let value = accumulator.value() {
            stack.push(value)
            accumulator.clear()
        }
    }
    
    public func currentValue() -> Double {
        if let accumulated = accumulator.value() {
            return accumulated
        } else if let top = stack.peek() {
            return top
        } else {
            return 0
        }
    }
    
    
    public mutating func push(operator op: Operator) {
        go() // accumlate whatever's on the stack
        
        let rhs = stack.pop() ?? 0.0
        let lhs = stack.pop() ?? 0.0
        
        let result: Double
        switch op {
            
        case .add:
            result = lhs + rhs
        case .subtract:
            result = lhs - rhs
        case .multiply:
            result = lhs * rhs
        case .divide:
            result = lhs / rhs
        }
        
        stack.push(result)
    }
    
    public mutating func reset() {
        accumulator.clear()
        stack.clear()
    }
    
}
