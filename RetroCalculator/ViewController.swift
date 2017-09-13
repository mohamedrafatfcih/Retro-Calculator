//
//  ViewController.swift
//  RetroCalculator
//
//  Created by RANDOM on 9/12/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    enum Operation : String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    
    
    @IBAction func onClearPressed(_ sender: Any) {
        playSound()
        outputLbl.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
    }
    
    @IBAction func btnPressedSound(_ sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(operation: .Add)
    }
    @IBAction func onSubPressed(_ sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onDividePressed(_sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOperation(operation: currentOperation)
    }

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! +  Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! -  Double(rightValStr)!)"
                }else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! *  Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                   result = "\(Double(leftValStr)! /  Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
               
            }
            currentOperation = operation
    }
        else{
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

