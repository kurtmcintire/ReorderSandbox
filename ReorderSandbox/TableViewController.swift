//
//  TableViewController.swift
//  ReorderSandbox
//
//  Created by Kurt McIntire on 11/10/17.
//  Copyright © 2017 KurtMcIntire. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var dataSource: [String] = ["They've been solid! I want to buy some more but waiting for approval from the other half.",
                             "BTC is going through a correction this morning. I'll be ready if ETH drops below 290 again. Same goes for sub 53 LTC, but LTC looks like it's holding much stronger against the BTC drop than ETH.",
                             "Yeah, for sure. I still hold strong that next May all three will be 2-5x what they are now.",
                             "The FOMO is so high for me now. Everyday I go: Will I regret not buying bitcoin in three months as much as I regret it today, not buying more it three months ago?",
                             "Bitcoin well over 7,000 this morning, boys. I'm shook.",
                             "Facepalm"]
    
    var colorDataSource: [UIColor] = [.green, .blue, .purple, .gray, .red, .orange]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = true
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        cell.mainLabel.text = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item: String = dataSource[sourceIndexPath.row]
        
        dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(item, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
