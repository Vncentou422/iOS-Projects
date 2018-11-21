//
//  Drawing.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 University of Rochester. All rights reserved.
//

import Foundation
import UIKit

class QDDocument: NSObject, NSCoding {
    
    static func == (lhs: QDDocument, rhs: QDDocument) -> Bool {
        return lhs.title == rhs.title && lhs.date == rhs.date
    }
    
    var title: String
    var date: Date
    var lines: [QDLine]
    var roundBrush: Bool
    var tint: UIColor
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case title, date, lines, roundBrush, tint, count
    }
    
    init(title: String, date: Date, lines: [QDLine], roundBrush: Bool = true, tint: UIColor, count: Int) {
        if count != 0 {
            self.title = title + " " + String(count)
        }
        else {
            self.title = title
        }
        self.date = date
        self.lines = lines
        
        self.roundBrush = roundBrush
        self.tint = tint
        self.count = count
    }
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        title = try container.decode(String.self, forKey: .title)
//        date = try container.decode(Date.self, forKey: .date)
//        lines = try container.decode(Array.self, forKey: .lines)
//
//        roundBrush = try container.decode(Bool.self, forKey: .roundBrush)
//        count = try container.decode(Int.self, forKey: .count)
//        let colorData = try container.decode(Data.self, forKey: .tint)
//        tint = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor ?? UIColor.black
//
//    }
//    convenience init(){
//        let lines = [QDLine]()
//        self.init(title: "Untitled", date: Date(), lines: lines, roundBrush: false, tint: .black)
//    }
    convenience init(title: String, count: Int) {
        let lines = [QDLine]()
        self.init(title: title, date: Date(), lines: lines, roundBrush: false, tint: .black, count: count)
    }
    
//    func encode(to encoder: NSCoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(title, forKey: .title)
//        try container.encode(date, forKey: .date)
//        try container.encode(lines, forKey: .lines)
//
//        let colorData = NSKeyedArchiver.archivedData(withRootObject: tint)
//        try container.encode(colorData, forKey: .tint)
//
//        try container.encode(roundBrush, forKey: .roundBrush)
//    }
    required init(coder aDecoder: NSCoder) {
        
        title = aDecoder.decodeObject(forKey: CodingKeys.title.rawValue) as! String
        date = aDecoder.decodeObject(forKey: CodingKeys.date.rawValue) as! Date
        lines = aDecoder.decodeObject(forKey: CodingKeys.lines.rawValue) as! [QDLine]
        roundBrush = aDecoder.decodeObject(forKey: CodingKeys.roundBrush.rawValue) as? Bool ?? false
        tint = aDecoder.decodeObject(forKey: CodingKeys.tint.rawValue) as! UIColor
        count = aDecoder.decodeObject(forKey: CodingKeys.count.rawValue) as? Int ?? 0
     }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(title, forKey: CodingKeys.title.rawValue)
        aCoder.encode(date, forKey: CodingKeys.date.rawValue)
        aCoder.encode(lines, forKey: CodingKeys.lines.rawValue)
        aCoder.encode(roundBrush, forKey: CodingKeys.roundBrush.rawValue)
        aCoder.encode(tint, forKey: CodingKeys.tint.rawValue)
        aCoder.encode(count, forKey: CodingKeys.count.rawValue)
    }
    
    
}



































