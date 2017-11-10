//
//  ViewController.swift
//  PinPointReorderSandbox
//
//  Created by Kurt McIntire on 11/9/17.
//  Copyright © 2017 KurtMcIntire. All rights reserved.
//

import UIKit

//# MARK: - ViewController Class

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [Int] = [30, 60, 90, 120, 150, 180]
    var colorDataSource: [UIColor] = [.green, .blue, .purple, .gray, .red, .orange]
    var customLayout: CustomFlowLayout = CustomFlowLayout()
    var isMoving: Bool = false
//    var movingCell: CustomCell = CustomCell?
    
    
    //# MARK: - Private Functions
    
    fileprivate func setupView() {
        collectionView.setCollectionViewLayout(customLayout, animated: false)
        collectionView.isPagingEnabled = true
    }
    
    fileprivate func setupGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            self.isMoving = true
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            self.isMoving = true
        
        case .ended:
            collectionView.endInteractiveMovement()
            self.isMoving = false
        
        default:
            collectionView.cancelInteractiveMovement()
            self.isMoving = false
        }
    }
    
    
    //# MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }
}


//# MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UICollectionViewCell()
        }
        
        cell.mainLabel.text = String(dataSource[indexPath.row])
        cell.backgroundColor = colorDataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = dataSource[sourceIndexPath.row]
        let color = colorDataSource[sourceIndexPath.row]
        
        /*
        print("Source Row: \(sourceIndexPath.row)")
        
        if let sourceCell = collectionView.cellForItem(at: sourceIndexPath) {
            print("Source Cell: " + sourceCell.description)
        }
        
        print("Destination Row: \(destinationIndexPath.row)")
        
        if let destinationCell = collectionView.cellForItem(at: destinationIndexPath) {
             print("Destination Cell: " + destinationCell.description)
        }
        */
        
        dataSource.remove(at: sourceIndexPath.row)
        colorDataSource.remove(at: sourceIndexPath.row)
        
        dataSource.insert(item, at: destinationIndexPath.row)
        colorDataSource.insert(color, at: destinationIndexPath.row)
        
        collectionView.reloadData()
    }
}


//# MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


//# MARK: - CustomFlowLayoutDelegate

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = dataSource[indexPath.row]
        
        if let sizingCell = collectionView.cellForItem(at: indexPath) {
            print("Sizing Cell: " + sizingCell.description)
        }
        
        return CGSize.init(width: view.frame.size.width, height: CGFloat(height))
    }
}

