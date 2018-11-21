//
//  QDLibrary.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import Foundation
import UIKit

class QDLibrary: NSObject, NSCoding {
    
    var documents = [QDDocument]()
    
    override init() {
        super.init()
        
        addItem(QDDocument(title: "Untitled", count : 0))
    }
    
    func addItem(_ item: QDDocument) {
        documents.append(item)
    }
    
    func removeItem(at index: Int) -> Int {
        if documents.count != 1{
            let count = documents[index].count
            documents.remove(at: index)
            return count
        }
        else{
            return 0
        }
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        if fromIndex != toIndex {
            let item = documents[fromIndex]
            documents.remove(at: fromIndex)
            documents.insert(item, at: toIndex)
        }
    }
    
    
    
    // MARK: - NSCoder
    
    required init(coder aDecoder: NSCoder) {
        documents = aDecoder.decodeObject(forKey: "items") as! [QDDocument]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(documents, forKey: "items")
    }
    
}
