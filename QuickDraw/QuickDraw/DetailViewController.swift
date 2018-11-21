//
//  DetailViewController.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var topBar: UINavigationItem!
    
    @IBOutlet var drawView: DrawView! {
        didSet {
            drawView.delegate = self
        }
    }
    
    var document: QDDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let detail = detailItem {
            self.navigationItem.title = detail.title
        }
        drawView?.roundBrush = (detailItem?.roundBrush)!
        drawView?.tint = (detailItem?.tint)!
        drawView?.lines = (detailItem?.lines)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: QDDocument? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    @IBAction func onEraseBtn(_ sender: Any) {
        document?.lines.removeAll()
        configureView()
    }
    @IBAction func onSquareBtn(_ sender: Any) {
        document?.roundBrush = false
        configureView()
    }
    @IBAction func onRoundBtn(_ sender: Any) {
        document?.roundBrush = true
        configureView()
    }
    
    @IBAction func onBlackBtn(_ sender: Any) {
        document?.tint = .black
        configureView()
    }
    @IBAction func onRedBtn(_ sender: Any) {
        document?.tint = .red
        configureView()
    }
    
    @IBAction func onGreenBtn(_ sender: Any) {
        document?.tint = .green
        configureView()
    }
    
    @IBAction func onBlueBtn(_ sender: Any) {
        document?.tint = .blue
        configureView()
    }
    
    
}
extension ViewController: DrawViewDelegate {
    func updateLines(_ drawView: DrawView, lines: [QDLine]) {
        document?.lines = lines
    }
}

