//
//  LXWaterfallLayout.swift
//  LXFoundationManager
//
//  Created by Mac on 2020/4/23.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

protocol LXWaterfallLayoutDataSource: AnyObject {
    func waterfallLayout(_ layout: LXWaterfallLayout,w: CGFloat, indexPath: IndexPath) -> CGFloat
    func numberOfColsInWaterfallLayout(_ layout: LXWaterfallLayout) -> Int
}

// MARK: - 瀑布流
class LXWaterfallLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: LXWaterfallLayoutDataSource?
    
    // MARK: 私有延时属性
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate var totalHeight: CGFloat = 0
    fileprivate lazy var colHeights: [CGFloat] = {
        let cols = self.dataSource!.numberOfColsInWaterfallLayout(self)
        var colHeights = Array(repeating: self.sectionInset.top, count: cols)
        return colHeights
    }()
    fileprivate var maxH: CGFloat = 0
    fileprivate var startIndex = 0
}

extension LXWaterfallLayout {
    
    override func prepare() {
        super.prepare()
        
        // 获取item的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        // 获取列数
        let cols = dataSource!.numberOfColsInWaterfallLayout(self)
        // 计算Item的宽度
        let itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / CGFloat(cols)
        
        // 计算所有的item的属性
        for i in startIndex..<itemCount {
            // 设置每一个Item位置相关的属性
            let indexPath = IndexPath(item: i, section: 0)
            
            // 根据位置创建Attributes属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 获取高度
            guard let height = dataSource?.waterfallLayout(self, w: itemW, indexPath: indexPath) else {fatalError("请设置数据源,并且实现对应的数据源方法")}
            
            // 取出最小列的位置
            var minH = colHeights.min()!
            let index = colHeights.firstIndex(of: minH)!
            minH = minH + height + minimumLineSpacing
            colHeights[index] = minH
            
            // 设置item的属性
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemW) * CGFloat(index), y: minH - height - self.minimumLineSpacing, width: itemW, height: height)
            
            if !attrsArray.contains(attrs) {
                attrsArray.append(attrs)
            }
        }
        
        // 记录最大值
        maxH = colHeights.max()!
        
        // 给startIndex重新复制
        startIndex = itemCount
    }
}

extension LXWaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
}

