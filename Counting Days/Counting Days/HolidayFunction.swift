//
//  HolidayFunction.swift
//  Counting Days
//
//  Created by Vincent Ou on 11/2/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation

import UIKit

struct Tile :Codable {
    var index : Int
    var faceUp : Bool
    var emoji : String
}

class HolidayFunction {
    
    private let emojis = "🌟🎄❄️"
    var tilesArray = [Tile]()
    var counter = 0
    func initialize(){
        
        for i in 0..<24 {
            let tile = Tile(index: i, faceUp: false, emoji: "🌟")
            tilesArray.append(tile)
        }
    }
    
    
    func isFaceUp(_ index: Int) -> Bool {
        return tilesArray[index].faceUp
    }
    func getCounter() -> Int{
        return counter
    }
    
    func faceUpTiles() -> [Tile] {
        return tilesArray.filter { $0.faceUp == true }
    }
    func toggleFaceUp(_ index: Int) {
        tilesArray[index].faceUp = true
        counter += 1
    }
    
    func reset(){
        for i in 0..<tilesArray.count{
            tilesArray[i].faceUp = false
        }
        counter = 0
    }
}
