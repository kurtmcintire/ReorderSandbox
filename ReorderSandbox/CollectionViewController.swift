//
//  CollectionViewController.swift
//  ReorderSandbox
//
//  Created by Kurt McIntire on 11/10/17.
//  Copyright © 2017 KurtMcIntire. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var dataSource: [String] = ["They've been solid! I want to buy some more but waiting for approval from the other half.",
                                "BTC is going through a correction this morning. I'll be ready if ETH drops below 290 again. Same goes for sub 53 LTC, but LTC looks like it's holding much stronger against the BTC drop than ETH.",
                                "Yeah, for sure. I still hold strong that next May all three will be 2-5x what they are now.",
                                "The FOMO is so high for me now. Everyday I go: Will I regret not buying bitcoin in three months as much as I regret it today, not buying more it three months ago?",
                                "Bitcoin well over 7,000 this morning, boys. I'm shook.",
                                "Facepalm"]
    
    var colorDataSource: [UIColor] = [.green, .blue, .purple, .gray, .red, .orange]
    
    fileprivate func setupGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(CollectionViewController.handleLongPress(_:)))
        collectionView?.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case .ended:
            collectionView?.endInteractiveMovement()
            
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 100)
        }
        setupGesture()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResizingCollectionViewCell", for: indexPath) as? ResizingCollectionViewCell else { return UICollectionViewCell() }
        
        let text = dataSource[indexPath.row]
        cell.mainLabel.text = text
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = dataSource[sourceIndexPath.row]
        dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(item, at: destinationIndexPath.row)
        collectionView.reloadData()
    }
}
