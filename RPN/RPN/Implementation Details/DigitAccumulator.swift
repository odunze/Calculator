//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

internal struct DigitAccumulator {
    
    private var digits = Array<Digit>()
 
    internal init() { }
    
    internal mutating func add(digit: Digit) throws {
        switch digit {
            
        case .number(let value):
            if value < 0 || value > 9 {
                throw Digit.Error.invalidDigitValue
            }
            
        case .decimalPoint:
            // there can be only one
            // highlander decimal point
            if digits.contains(.decimalPoint) {
                throw Digit.Error.tooManyDecimalPoints
            }
        }
        
        digits.append(digit)
    }
    
    internal func value() -> Double? {
        if digits.isEmpty { return nil }
        
        // the string "." does not convert into a number correctly
        // so we'll manually detect that case and handle it
        if digits == [.decimalPoint] { return 0.0 }
        
        // [., 2, 5] -> [".", "2", "5"] -> ".25" -> 0.25
        let digitString = digits.map { digit -> String in
            switch digit {
                case .decimalPoint: return "."
                case .number(let i): return "\(i)"
            }
        }.joined()
        
        return Double(digitString)
    }
    
    internal mutating func clear() {
        digits = []
    }
    
}
