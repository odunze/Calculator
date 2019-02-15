//
//  PrefixCalculator.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

public struct PrefixCalculator: Calculator {
    
    private enum Command {
        case number(Double)
        case `operator`(Operator)
        
        var number: Double? {
            guard case .number(let n) = self else { return nil }
            return n
        }
        
        var `operator`: Operator? {
            guard case .operator(let o) = self else { return nil }
            return o
        }
        
        var isNumber: Bool { return number != nil }
    }
    
    public let name = "Prefix"
    
    private var commands = Stack<Command>()
    private var accumulator = DigitAccumulator()
    
    public init() { }
    
    public mutating func push(digit: Digit) throws {
        try accumulator.add(digit: digit)
    }
    
    public mutating func push(operator: Operator) {
        if let value = accumulator.value() {
            commands.push(.number(value))
            accumulator.clear()
            go()
        }
        commands.push(.operator(`operator`))
    }
    
    public mutating func go() {
        if let value = accumulator.value() {
            commands.push(.number(value))
            accumulator.clear()
        }
        
        while let rhs = commands.peek()?.number, let lhs = commands.peek(offset: 1)?.number, let op = commands.peek(offset: 2)?.operator {
            
            commands.pop(); commands.pop(); commands.pop()
            
            let result: Double
            switch op {
            case .add: result = lhs + rhs
            case .subtract: result = lhs - rhs
            case .multiply: result = lhs * rhs
            case .divide: result = lhs / rhs
            }
            commands.push(.number(result))
        }
    }
    
    public mutating func reset() {
        commands.clear()
        accumulator.clear()
    }
    
    public func currentValue() -> Double {
        if let value = accumulator.value() {
            return value
        } else if let mostRecentNumber = commands.first(where: { $0.isNumber }) {
            return mostRecentNumber.number!
        } else {
            return 0.0
        }
    }
    
    
}
