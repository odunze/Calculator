//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Spencer Curtis on 1/9/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit
import RPN

class CalculatorViewController: UIViewController, UITextFieldDelegate {

    init(calculator: Calculator) {
        self.calculator = calculator
        super.init(nibName: "CalculatorViewController", bundle: nil)
        
        tabBarItem.title = calculator.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let number = sender.tag
        try? calculator.push(digit: .number(number))
    }
    
    @IBAction func decimalButtonTapped(_ sender: Any) {
        try? calculator.push(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        calculator.go()
    }
    
    @IBAction func divideButtonTapped(_ sender: Any) {
        calculator.push(operator: .divide)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: Any) {
        calculator.push(operator: .multiply)
    }
    
    @IBAction func subtractButtonTapped(_ sender: Any) {
        calculator.push(operator: .subtract)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        calculator.push(operator: .add)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        calculator.reset()
        return true
    }
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()

    private var calculator: Calculator {
        didSet {
            let value = calculator.currentValue()
            textField.text = numberFormatter.string(from: value as NSNumber)
        }
    }
    
    @IBOutlet weak var textField: UITextField!
}
