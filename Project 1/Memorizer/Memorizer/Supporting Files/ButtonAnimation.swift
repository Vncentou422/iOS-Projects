//
//  ButtonAnimation.swift
//  Memorizer
//
//  Created by Vincent Ou on 10/3/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    //source from https://www.objc.io/issues/12-animations/animations-explained/
    func flash(){
        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.beginTime = CACurrentMediaTime() + 0.3
        flash.duration = 0.4
        flash.fromValue = 1.0
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        
        
        
        layer.add(flash, forKey: nil)
    }
}
