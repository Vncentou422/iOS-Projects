//
//  MasterViewController.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 Vincent Ou. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects : QDLibrary!
    var nextNum = 1
    var deletedNum = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
//        print(QDDocument(title: "Untitled"))
        if deletedNum.count == 0 {
            let item = QDDocument(title: "Untitled", count : nextNum)
            nextNum += 1
            objects.addItem(item)
        }
        else {
            print(deletedNum)
            print(deletedNum[0])
            let item = QDDocument(title: "Untitled", count : deletedNum[0])
            deletedNum.removeFirst()
            objects.addItem(item)
        }
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = objects?.documents[indexPath.row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects?.documents.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = objects?.documents[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ind = objects.documents[indexPath.row].count
            let ind2 = objects.removeItem(at: indexPath.row)
            print(ind)
            print(ind2)
            deletedNum.append(ind)
            if objects.documents.count != 1{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else{
                let alertMsg = NSLocalizedString("str_deleteWarning", comment: "")
                let alert = UIAlertController(
                    title: NSLocalizedString("str_warning", comment: ""),
                    message: alertMsg,
                    preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                                 style: .cancel, handler:nil)
                
                alert.addAction(cancelAction)
                alert.popoverPresentationController?.permittedArrowDirections = []
                alert.popoverPresentationController?.sourceView = self.view
                alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                
                present(alert, animated: true, completion: nil)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let alertMsg = NSLocalizedString("str_selectItemToMove", comment: "")

        let alert = UIAlertController(
            title: NSLocalizedString("str_warning", comment: ""),
            message: alertMsg,
            preferredStyle: .actionSheet)
        let moveAction = UIAlertAction(title: NSLocalizedString("str_move", comment: ""),
                                       style: .destructive, handler:nil)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(moveAction)
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
        objects?.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        
        
    }
    func insertAndSelectDocumentZero(){
       
    }


}

