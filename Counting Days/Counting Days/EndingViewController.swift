//
//  EndingViewController.swift
//  Counting Days
//
//  Created by Vincent Ou on 11/2/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation
import UIKit
protocol EndingViewControllerDelegate: class {
//    func addItem(_ item: MediaItem)
}
class EndingViewController : UIViewController {
    weak var delegate: EndingViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
