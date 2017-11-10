//
//  CustomFlowLayout.swift
//  ReorderSandbox
//
//  Created by Kurt McIntire on 11/9/17.
//  Copyright © 2017 KurtMcIntire. All rights reserved.
//

import UIKit

@objc protocol CustomFlowLayoutDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView (_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    func fullWidth(forBounds bounds:CGRect) -> CGFloat {
        let contentInsets = self.collectionView!.contentInset
        return bounds.width - sectionInset.left - sectionInset.right - contentInsets.left - contentInsets.right
    }
    
    // MARK: Overrides
    
    override func prepare() {
        itemSize.width = fullWidth(forBounds: collectionView!.bounds)
        super.prepare()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if !newBounds.size.equalTo(collectionView!.bounds.size) {
            itemSize.width = fullWidth(forBounds: newBounds)
            return true
        }
        return false
    }
}

extension CustomFlowLayout {
        
    override open func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [IndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        return context
    }
}
