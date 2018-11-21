//
//  ViewController.swift
//  Memorizer
//
//  Created by Vincent Ou on 10/3/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    

    @IBOutlet var tilearray: [Button]!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelDescLabel: UILabel!
    @IBOutlet weak var restart: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
//    var timer = Timer()
    var clickable = false
    let game = Game()
    override func viewDidLoad() {
        super.viewDidLoad()
        restart.isUserInteractionEnabled = true
        
        for (i, tile) in tilearray.enumerated() {
            tile.index = i
            if i == 0{
                tile.backgroundColor = UIColor.blue
            }
            if i == 1{
                tile.backgroundColor = UIColor.red
            }
            if i == 2{
                tile.backgroundColor = UIColor.purple
            }
            if i == 3{
                tile.backgroundColor = UIColor.orange
            }
//            print("\(i): '\(tile)'")
        }
        levelLabel.text = String(game.getLevel())
        game.playGame()
        update()
        
    }
    @IBAction func restartTapped(recognizer:UITapGestureRecognizer) {
        print("restart?")
        game.resetLevel()
        update()
    }
    
    func update(){
        game.increaseLevel()
        levelLabel.text = String(game.getLevel())
        game.playGame()
        let order = game.getSequence()
        showSequence(str: order)
        
    }
    func showSequence(str: String){
        clickable = false
        var retStr = ""
        for i in str{
            
         
                if i == "0" {

                    retStr = retStr + "B"
                }
                if i == "1" {

                    retStr = retStr + "R"
                }
                if i == "2" {

                    retStr = retStr + "P"
                }
                if i == "3" {

                    retStr = retStr + "O"
                }
            
            print(retStr)
        }
        textLabel.textColor = UIColor.white
        textLabel.text = retStr
        
        delay(delay: 3.0){
            self.textLabel.textColor = UIColor.white
//            self.textLabel.text = "Repeat the sequence"
            self.textLabel.text = NSLocalizedString("repeatThesentence", comment: "Repeat the Sentence")
            self.clickable = true
        }
    }
    //source of delay function from https://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
    func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func tileTapped(_ sender: Button) {
//        print(ssender.flash()
        if game.getWrong(){
            textLabel.textColor = UIColor.red
            textLabel.text = NSLocalizedString("gameOver", comment: "Game Over")
            
        }
        else if clickable{
            game.pressed(index: sender.index)
            sender.flash()
        }
        if game.completed(){
            print("complete")
            update()
        }
        
//        game.increaseLevel()
//        levelLabel.text = String(game.getLevel())    }
    }
}

