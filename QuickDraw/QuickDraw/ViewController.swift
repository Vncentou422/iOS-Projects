//
//  ViewController.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 University of Rochester. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var drawView: DrawView! {
        didSet {
            drawView.delegate = self
        }
    }
    var detailItem: QDDocument? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    var document: QDDocument?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Utility
    
    func configureView() {
        if let detail = detailItem {
            self.navigationItem.title = detail.title
        }
        drawView?.roundBrush = (document?.roundBrush)!
        drawView?.tint = (document?.tint)!
        drawView?.lines = (document?.lines)!
    }

    // MARK: - Actions
    
    @IBAction func onEraserBtn(_ sender: UIBarButtonItem) {
        document?.lines.removeAll()
        configureView()
    }
    
    @IBAction func onSquareShapeBtn(_ sender: Any) {
        document?.roundBrush = false
        configureView()
    }
    @IBAction func onRoundShapeBtn(_ sender: Any) {
        document?.roundBrush = true
        configureView()
    }
    
    @IBAction func onBlackColorBtn(_ sender: Any) {
        document?.tint = .black
        configureView()
    }
    @IBAction func onRedColorBtn(_ sender: Any) {
        document?.tint = .red
        configureView()
    }
    @IBAction func onGreenColorBtn(_ sender: Any) {
        document?.tint = .green
        configureView()
    }
    @IBAction func onBlueColorBtn(_ sender: Any) {
        document?.tint = .blue
        configureView()
    }
}

extension DetailViewController: DrawViewDelegate {
    func updateLines(_ drawView: DrawView, lines: [QDLine]) {
        document?.lines = lines
    }
}

