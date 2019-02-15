//
//  Digit.swift
//  RPN
//
//  Created by Dave DeLong on 2/13/19.
//  Copyright © 2019 Syzygy. All rights reserved.
//

import Foundation

public enum Digit: Equatable {
    
    public enum Error: Swift.Error {
        case invalidDigitValue
        case tooManyDecimalPoints
    }
    
    case number(Int)
    case decimalPoint
}
