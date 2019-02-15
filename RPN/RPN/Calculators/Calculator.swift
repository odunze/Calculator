//
//  Calculator.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

public protocol Calculator {
    
    var name: String { get }
    
    mutating func push(digit: Digit) throws
    mutating func push(operator: Operator)
    mutating func go()
    
    mutating func reset()
    
    func currentValue() -> Double
    
}
