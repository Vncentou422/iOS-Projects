//
//  DayView.swift
//  Counting Days
//
//  Created by Vincent Ou on 11/2/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation
import UIKit


protocol DayTileViewDelegate: class  {
    func shouldFlip(_ DayView: DayView, index: Int) -> Bool
    func didFlip(_ DayView: DayView, index: Int)
}

class DayView : UIView {
    
    @IBOutlet weak var day : UILabel?
  
    weak var delegate: DayTileViewDelegate?
    var index = 0
    var isFlipped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    var title: String = "" {
        didSet {
            day?.text = title
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        if (delegate?.shouldFlip(self, index: self.index))! {
            animateFlip()
            isFlipped = true
        }
    }
    func animateFlipBack() {
        if isFlipped {
            UIView.transition(
                with: self,
                duration: 0.5,
                options: [.transitionFlipFromRight],
                animations: {
                    self.day?.text = String(self.index + 1)
//                    if self.index == 1{
//                        self.day?.text = String(self.index + 2)
//                    }
//                    if self.index == 2{
//                        self.day?.text = String(self.index )
//                    }
                    self.isFlipped = false
            })
        }
    }
        
    
    func animateFlip() {
        
        UIView.transition(
            with: self,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                self.delegate?.didFlip(self, index: self.index)
                if self.index == 23 {
                    self.day?.text = "🎄"
                }
                else{
                self.day?.text = "🌟"
                }
        })
//        day?.text = "🌟"
    }
    
}
