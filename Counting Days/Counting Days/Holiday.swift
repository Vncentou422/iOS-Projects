//
//  Holiday.swift
//  Counting Days
//
//  Created by Vincent Ou on 11/2/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation
import UIKit

class Holiday : UIViewController , DayTileViewDelegate{
    func shouldFlip(_ DayView: DayView, index: Int) -> Bool {
        if testMode == false{
            if holidayFunc.isFaceUp(index) {
                return false
            }
            else if index != holidayFunc.getCounter() {
                print("index")
                print(index)
                print("counter")
                print(holidayFunc.getCounter())
                outOfOrderAlert()
                return false
            }
        }
        
        return true
    }
    
    func didFlip(_ DayView: DayView, index: Int) {
        holidayFunc.toggleFaceUp(index)

    }
    
    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet var tiles: [DayView]!
    var testMode = false
    let holidayFunc = HolidayFunction()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        holidayFunc.initialize()
        for i in 0..<tiles.count {
            tiles[i].index = holidayFunc.tilesArray[i].index
            tiles[i].delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EndingScreenSegue" {
            print("hello")
//            if let endScreenViewController = segue.destination as? EndingViewController  {
//                endScreenViewController.delegate = self
//            }
        }
        if segue.identifier == "PopOverSegue" {
            print("hello")
            //            if let endScreenViewController = segue.destination as? EndingViewController  {
            //                endScreenViewController.delegate = self
            //            }
        }

    }
    func outOfOrderAlert(){
        let alertMsg = NSLocalizedString("str_outofOrder", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .actionSheet)
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any!) -> Bool {
        if identifier == "EndingScreenSegue" {
            
            if holidayFunc.getCounter() == 23 || self.testMode == true{
                
                return true
            }
                
            else {
                outOfOrderAlert()
                return false
            }
        }
        if identifier == "PopOverSegue" {
            
            return true
        }
        return false
    }
    
        
        // by default, transition
        
    func resetAlert() {
        
        let alertMsg = NSLocalizedString("str_reset", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("str_yes", comment: ""),
                                         style: .destructive, handler:{(action) in self.reset()})
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func toggleReset(_ sender: Any) {
        resetAlert()
       
    }
    @IBAction func selectHoliday(_ sender: Any) {
        print("hello")
    }
    
    func reset(){
        for tile in tiles{
            tile.animateFlipBack()
        }
        holidayFunc.reset()
    }
    @IBAction func pressed(_ sender: Any) {
        
        if testMode == false{
            testMode = true
            print(testMode)
        }
        else{
            testMode = false
            reset()
            print(testMode)
        }
    }
    
    @IBAction func HolidayPressed(_ sender: Any) {
        print(holidayFunc.getCounter())
        if holidayFunc.getCounter() == 23 {
            print("hello")
        }
    }
    
    
}
