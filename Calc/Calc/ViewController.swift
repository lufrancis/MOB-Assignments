//
//  ViewController.swift
//  Calc
//
//  Created by George Geicke on 6/7/15.
//  Copyright (c) 2015 George Geicke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelDisplay: UILabel!
    
    var numberString: String = ""
    var decimalPressed: Bool = false
    var numberDouble: Double = 0.0
    var numberOne: Double = 0.0
    var doubleOfLabel: Double = 0.0
    var operatorSign: String = ""
    var boolPreviousOperator: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayLabel (numberDouble: Double)  {
        doubleOfLabel = numberDouble
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        labelDisplay.text = formatter.stringFromNumber(numberDouble)
    }
    
    func numberPressed (inputString:String) {
        if numberString == "0" || numberString == "" {
            numberString = inputString
        }
        else {
            numberString = numberString + inputString
        }
        labelDisplay.text = numberString
        println(numberString)
        numberDouble = NSNumberFormatter().numberFromString(numberString)!.doubleValue
        displayLabel(numberDouble)
        boolPreviousOperator = false
    
    }

    func calculate () {
        if operatorSign == "=" || operatorSign == "%" || operatorSign == "Sign" {
            numberOne = doubleOfLabel
        }

        if operatorSign != "" {
 
            if operatorSign == "+" {
                numberOne = (numberOne + numberDouble)
            }
            else if operatorSign == "-" {
                numberOne = (numberOne - numberDouble)
            }
            else if operatorSign == "x" {
                numberOne = (numberOne * numberDouble)
            }
            else if operatorSign == "/" {
                numberOne = (numberOne / numberDouble)
            }
        }
        else {
            numberOne = numberDouble
            numberDouble = 0.0
        }
    }


    
    @IBAction func ACClicked(sender: AnyObject) {
//        numberDouble = NSNumberFormatter().numberFromString(numberString)!.doubleValue
        numberDouble = 0.0
        numberOne = 0.0
        operatorSign = ""
        numberString = "0"
//        numberString = String(format: "%f", numberDouble)
        displayLabel(numberDouble)
    }
    
    @IBAction func SignClicked(sender: AnyObject) {
//        numberString = labelDisplay.text!
        numberOne = doubleOfLabel
        numberOne = numberOne * -1
//        numberString = String(format: "%f", numberDouble)
        displayLabel(numberOne)
        numberDouble = 0.0

    
    }
    
    @IBAction func PercentageClicked(sender: AnyObject) {
//        numberString = labelDisplay.text!
//        println(labelDisplay.text)
//        println(numberString)
        numberOne = doubleOfLabel
        numberOne = numberOne / 100
//        numberString = String(format: "%f", numberDouble)
        displayLabel(numberOne)
        operatorSign = "%"
        numberString = labelDisplay.text!
        decimalPressed = false
        boolPreviousOperator = true
        //        println(String(format: "%f", numberOne))
//                labelDisplay.text = String(format: "%f", numberOne)
        
        
        numberDouble = 0.0
        
        
        
    }
    
    @IBAction func DivideClicked(sender: AnyObject) {
        if boolPreviousOperator == false {
            calculate()
        }
        operatorSign = "/"
        numberString = ""
        decimalPressed = false
        boolPreviousOperator = true
        println(String(format: "%f", numberOne))
        //labelDisplay.text = String(format: "%f", numberOne)
        displayLabel(numberOne)
    }
    

    @IBAction func MultipliedClicked(sender: AnyObject) {
        if boolPreviousOperator == false {
            calculate()
        }
        operatorSign = "x"
        numberString = ""
        decimalPressed = false
        boolPreviousOperator = true
//        println(String(format: "%f", numberOne))
        displayLabel(numberOne)
    }
    
    @IBAction func MinusClicked(sender: AnyObject) {
        if boolPreviousOperator == false {
            calculate()
        }
        operatorSign = "-"
        numberString = ""
        decimalPressed = false
        boolPreviousOperator = true
//        println(String(format: "%f", numberOne))
        displayLabel(numberOne)
        
        
    }
    
    @IBAction func PlusClicked(sender: AnyObject) {
        if boolPreviousOperator == false {
            calculate()
        }
        operatorSign = "+"
        numberString = ""
        decimalPressed = false
        boolPreviousOperator = true
//        println(String(format: "%f", numberOne))
        displayLabel(numberOne)
     
    }
    
    @IBAction func EqualClicked(sender: AnyObject) {
        if boolPreviousOperator == false {
            calculate()
        }
        displayLabel(numberOne)
        operatorSign = "="
        numberString = ""
        decimalPressed = false
        boolPreviousOperator = true
//        println(String(format: "%f", numberOne))
//        labelDisplay.text = String(format: "%f", numberOne)
        

        numberDouble = 0.0
        
        
        
    }
    
    @IBAction func DecimalClicked(sender: AnyObject) {
                  if decimalPressed == false {
                numberString = numberString + "."
                labelDisplay.text = numberString
                decimalPressed = true
        }
        
        
    }
    
    
    @IBAction func ZeroClicked(sender: AnyObject) {
        numberPressed("0")
    }
    
    @IBAction func OneClicked(sender: AnyObject) {
        numberPressed("1")
    }
    
    
    @IBAction func TwoClicked(sender: AnyObject) {
        numberPressed("2")
    }
    

    @IBAction func ThreeClicked(sender: AnyObject) {
        numberPressed("3")
    }
   
    @IBAction func FourClicked(sender: AnyObject) {
        numberPressed("4")
    }
    
    
    @IBAction func FiveClicked(sender: AnyObject) {
        numberPressed("5")
    }
    
    
    @IBAction func SixClicked(sender: AnyObject) {
        numberPressed("6")
    }

    @IBAction func Clicked(sender: AnyObject) {
        numberPressed("7")
    }
    
    @IBAction func EightClicked(sender: AnyObject) {
        numberPressed("8")
    }
    
    @IBAction func NineClicked(sender: AnyObject) {
        numberPressed("9")
    }

    
}

