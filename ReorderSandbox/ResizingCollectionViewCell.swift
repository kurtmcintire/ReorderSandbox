//
//  ResizingCollectionViewCell.swift
//  ReorderSandbox
//
//  Created by Kurt McIntire on 11/10/17.
//  Copyright © 2017 KurtMcIntire. All rights reserved.
//

import UIKit

class ResizingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        containerViewWidthConstraint.constant = screenWidth
    }
}
