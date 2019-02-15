//
//  InfixCalculator.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

public struct InfixCalculator: Calculator {
    
    
    private var accumulator = DigitAccumulator()
    private var pendingOperator: Operator?
    private var result = 0.0
    
    public let name = "Infix"
    
    public init() { }
    
    public mutating func push(digit: Digit) throws {
        try accumulator.add(digit: digit)
    }
    
    public mutating func push(operator: Operator) {
        if let value = accumulator.value() {
            result = value
            accumulator.clear()
        }
        
        pendingOperator = `operator`
    }
    
    public mutating func go() {
        guard let value = accumulator.value() else { return }
        accumulator.clear()
        
        if let op = pendingOperator {
            switch op {
                case .add:
                    result = result + value
                case .subtract:
                    result = result - value
                case .multiply:
                    result = result * value
                case .divide:
                    result = result / value
            }
        } else {
            result = value
        }
        
    }
    
    public mutating func reset() {
        result = 0
        pendingOperator = nil
        accumulator.clear()
    }
    
    public func currentValue() -> Double {
        if let value = accumulator.value() {
            return value
        }
        
        return result
    }
    
}
