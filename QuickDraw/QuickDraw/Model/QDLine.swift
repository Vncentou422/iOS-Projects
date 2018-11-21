//
//  Line.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 University of Rochester. All rights reserved.
//

import UIKit

class QDLine: NSObject, NSCoding {
    
    
    enum CodingKeys: String, CodingKey {
        case points
    }
    
    static func == (lhs: QDLine, rhs: QDLine) -> Bool {
        return lhs.points == rhs.points
    }
    
    var points = [CGPoint]()
    
    override init() {
    }
    convenience init(startingPoint: CGPoint) {
        self.init()
        self.points.append(startingPoint)
    }

    func addPoint(_ point: CGPoint) {
        points.append(point)
    }
    
    func encode(with aCoder: NSCoder) {
         aCoder.encode(points, forKey: CodingKeys.points.rawValue)
    }
    
    required init(coder aDecoder: NSCoder) {
        points = aDecoder.decodeObject(forKey: CodingKeys.points.rawValue) as! [CGPoint]
    }
}
