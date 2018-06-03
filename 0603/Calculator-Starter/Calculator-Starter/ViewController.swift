//
//  ViewController.swift
//  Calculator-Starter
//
//  Created by giftbot on 2018. 6. 1..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var titleNumber:[String?] = []
    var arithmeticOperation: String? = "basic"
    var beginNumber:String = ""
    var lastNumber:String = ""
    

    @IBOutlet private weak var displayLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func unWarpped () {
        if arithmeticOperation == "basic" {
            beginNumber = titleNumber.compactMap{ $0 }.reduce("") { $0 + $1 }
            displayLabel.text = beginNumber
        } else {
            lastNumber = titleNumber.compactMap{ $0 }.reduce("") { $0 + $1 }
            displayLabel.text = lastNumber
        }
    }
    
    
    func clearNumber () {
        titleNumber = []
        displayLabel.text = "0"
    }
    
    
    func sum (num1: String, num2: String) {
        beginNumber  = String(Int(num1)! + Int(num2)!)
        displayLabel.text = beginNumber
    }
    
    func sub (num1: String, num2: String) {
        if num1 < num2 {
            beginNumber = "-" + String(Int(num2)! - Int(num1)!)
            displayLabel.text = beginNumber
        } else {
            beginNumber = String(Int(num1)! - Int(num2)!)
            displayLabel.text = beginNumber
        }
    }
    
    func multiple (num1: String, num2: String) {
        beginNumber = String(Int(num1)! * Int(num2)!)
        displayLabel.text = beginNumber
    }
    
    func div (num1: String, num2: String) {
        beginNumber = String(Double(num1)! / Double(num2)!)
        displayLabel.text = beginNumber
    }
    
    
    
    
    @IBAction func colorChange(_ button: UIButton){
        button.backgroundColor = .gray
    }
    
    
    @IBAction func calculate(_ button: UIButton) {
        button.backgroundColor = .orange
        
        switch button.titleLabel?.text {
        case "+":
            arithmeticOperation = "+"
        case "−":
            arithmeticOperation = "−"
        case "*":
            arithmeticOperation = "*"
        case "/":
            arithmeticOperation = "/"
        default:
            print(arithmeticOperation)
        }
    

//        if button.titleLabel?.text == "C" || titleNumber.first == "0" || button.titleLabel?.text == arithmeticOperation {
        guard button.titleLabel?.text != "C" else {  displayLabel.text = "0"; titleNumber = []; beginNumber = "0"; lastNumber = ""; arithmeticOperation = "basic"; return }
        guard button.titleLabel?.text != arithmeticOperation else { titleNumber = []; return }
        

        if button.titleLabel?.text == "=" {
            if lastNumber == "" {
                displayLabel.text = beginNumber
            }else if arithmeticOperation == "+" {
                clearNumber()
                sum(num1: beginNumber, num2: lastNumber)
            } else if arithmeticOperation == "−" {
                clearNumber()
                sub(num1: beginNumber, num2: lastNumber)
            } else if arithmeticOperation == "*" {
                clearNumber()
                multiple(num1: beginNumber, num2: lastNumber)
            } else if arithmeticOperation == "/" {
                clearNumber()
                div(num1: beginNumber, num2: lastNumber)
            }
        } else {
            if button.titleLabel?.text != nil {
                titleNumber.append(button.titleLabel?.text)
                unWarpped()
            }
        }

    }
    

}

