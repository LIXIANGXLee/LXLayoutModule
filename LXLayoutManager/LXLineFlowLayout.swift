//
//  LXLineFlowLayout.swift
//  LXFoundationManager
//
//  Created by XL on 2020/4/29.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

// MARK: - 线性布局
class LXLineFlowLayout: UICollectionViewFlowLayout {
    
    public var isLineFlowLayoutScale: Bool?
    
    override func prepare() {
        super.prepare()
        /*
            水平滚动
        */
        self.scrollDirection = .horizontal;

         /*
            设置内边距
          */
        let inset = (self.collectionView!.frame.size.width - self.itemSize.width) * 0.5;
        self.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset);
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attsArray = super.layoutAttributesForElements(in: rect)else { return [] }
        let  centerX = self.collectionView!.frame.size.width / 2 + self.collectionView!.contentOffset.x
        for atts in attsArray  {
            let space = abs(atts.center.x - centerX);
            var scale = 1 - (space/self.collectionView!.frame.size.width * 0.35);
            if let isScale  = isLineFlowLayoutScale , isScale {
                scale = 1.0
            }
            atts.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }
        return attsArray;
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var contentOffset = CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
        var rect = CGRect.zero
        rect.origin.y = 0
        rect.origin.x = contentOffset.x
        rect.size = self.collectionView!.frame.size;
        
        guard let attsArray = super.layoutAttributesForElements(in: rect) else { return CGPoint.zero }
        let  centerX = contentOffset.x + self.collectionView!.frame.size.width / 2;
        var  minSpace = MAXFLOAT
        for attrs in attsArray {
            if (abs(minSpace) > Float(abs(attrs.center.x - centerX))) {
                minSpace = Float(attrs.center.x - centerX)
            }
        }
        contentOffset.x = contentOffset.x + CGFloat(minSpace)
        return contentOffset;
    }

}
