//
//  ViewController.swift
//  calculator
//
//  Created by non on 5/24/2559 BE.
//  Copyright © 2559 non. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {
    enum Operation : String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "empty"
    }
    @IBOutlet weak var outputLable : UILabel!
    var btnSound : AVAudioPlayer!
    var runningVal = ""
    var leftVal = ""
    var rightVal = ""
     var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func numberPressed(btn : UIButton!)
    {
        playSound()
        runningVal += "\(btn.tag)"
        outputLable.text = runningVal
        
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func OnDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    func processOperation(op : Operation){
        playSound()
        if currentOperation != Operation.Empty{
            //run some math
            if runningVal != ""{
            rightVal = runningVal
            runningVal = ""
            if currentOperation == Operation.Multiply{
                result = "\(Int(leftVal)! * Int(rightVal)!)"
            }else if currentOperation == Operation.Add{
                result = "\(Int(leftVal)! + Int(rightVal)!)"
            }else if currentOperation == Operation.Substract{
                result = "\(Int(leftVal)! - Int(rightVal)!)"
            }else{
                result = "\(Int(leftVal)! / Int(rightVal)!)"

            }
            leftVal = result
            outputLable.text = result
            }
            currentOperation = op
            
        }else{
            //this is the first time an operator has been pressed
            leftVal = runningVal
            runningVal = ""
            currentOperation = op
        }
    }
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
}

