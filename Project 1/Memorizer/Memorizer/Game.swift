//
//  Game.swift
//  Memorizer
//
//  Created by Vincent Ou on 10/3/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation

class Game{
    
    private var level = 0
    private var sequence = ""
    private var complete = false
    private var indexOfSequence = 0
    private var wrong = false
    func playGame(){
        complete = false
        wrong = false
        sequence = ""
        indexOfSequence = 0
        for _ in 0..<level {
            let number = String(Int(arc4random_uniform(4)))
            sequence += number
        }
        
        
        
        print(sequence)
    }
    
    func  getLevel() -> Int {
        return level
    }
    
    func completed() -> Bool{
        return complete
    }
    
    func increaseLevel(){
        level += 1
    }
    
    func resetLevel(){
        level = 0
        
    }
    func getSequence() -> String{
        return sequence
    }
    func getWrong() -> Bool{
        return wrong
    }
    func pressed(index: Int){
        let i = sequence.index(sequence.startIndex, offsetBy: indexOfSequence)
        if (String(index) == String(sequence[i])){
            wrong = false
            print(index)
            indexOfSequence += 1
            if (indexOfSequence > sequence.count - 1){
                complete = true
            }
        }
        else{
            wrong = true
        }
        
        
    }
    
}
