//
//  LXShowLayoutView.swift
//  LXLayoutModule
//
//  Created by XL on 2020/8/20.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

// MARK: - 枚举类型
public enum LXLayoutType {
    
    case vertical /// 垂直方向
    case horizontal /// 水平方向
    case lineFlow /// 线性布局 （ 默认垂直方向）
    case waterfallFlow /// 瀑布流 （水平方向）
}


public class LXShowLayoutView: UIView {
    
    private lazy var normalLayout: UICollectionViewFlowLayout = {
        let normalLayout = UICollectionViewFlowLayout()
        normalLayout.scrollDirection = (self.type == LXLayoutType.horizontal) ? .horizontal : .vertical
        return normalLayout
    }()
    
    /// 线性布局
    private lazy var linelayOut: LXLineFlowLayout = {
         let linelayOut = LXLineFlowLayout()
         return linelayOut
     }()
    
     /// 瀑布流
     private lazy var waterlayout: LXWaterfallLayout = {
        let waterlayout = LXWaterfallLayout()
        waterlayout.dataSource = self
        return waterlayout
     }()
    
    private lazy var collectionView: UICollectionView = {
       
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        return collectionView
    }()

    /// 布局类型
    private var type: LXLayoutType
    private var layout: UICollectionViewFlowLayout!

    public init(frame: CGRect,type: LXLayoutType = .vertical) {
        self.type = type
        super.init(frame: frame)
        
        switch self.type {
            case .horizontal:    /// 垂直布局
            layout = normalLayout
            case .vertical:      /// 水平布局
            layout = normalLayout
            case .lineFlow:      /// 线性布局
            layout = linelayOut
            case .waterfallFlow: /// 瀑布流
            layout = waterlayout

        }
                        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public weak var delegate: LXShowLayoutViewDelegate?
    public weak var dataSource: LXShowLayoutViewDataSource? {
        didSet{
            /// 注册数据源cell
            dataSource?.showLayoutView(self, registerClass: collectionView)
        }
    }
    
    public weak var waterSource: LXShowLayoutViewWaterSource?

    /// 是否可以分页
    public var isPagingEnabled: Bool? {
        didSet {
            guard let isPagingEnabled = isPagingEnabled else { return }
            collectionView.isPagingEnabled = isPagingEnabled
        }
    }    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LXShowLayoutView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = delegate?.showLayoutView?(self, sizeForItemAt: indexPath) ?? CGSize.zero
        if self.type == .lineFlow {
            self.linelayOut.itemSize = itemSize
        }
        return itemSize
    }
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return delegate?.showLayoutView?(self, minimumInteritemSpacingForSectionAt: section) ?? .leastNormalMagnitude
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        delegate?.showLayoutView?(self, minimumLineSpacingForSectionAt: section) ?? .leastNormalMagnitude
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return delegate?.showLayoutView?(self, referenceSizeForHeaderInSection: section) ?? CGSize.zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return delegate?.showLayoutView?(self, referenceSizeForFooterInSection: section) ?? CGSize.zero
    }
    
}

// MARK: - UICollectionViewDataSource
extension LXShowLayoutView: UICollectionViewDataSource {
        
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.showLayoutView?(self, numberOfSections: collectionView) ?? 1
    }
 
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return dataSource!.showLayoutView!(self, collectionView: collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource!.showLayoutView(self, collectionView: collectionView, numberOfItemsInSection: section)
     }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 数据源必须存在
        return dataSource!.showLayoutView(self, collectionView: collectionView, cellForItemAt: indexPath)
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showLayoutView?(self, didSelectItemAt: indexPath)
    
    }
    
}

extension LXShowLayoutView: LXWaterfallLayoutDataSource {
    func waterfallLayout(_ layout: LXWaterfallLayout, w: CGFloat, indexPath: IndexPath) -> CGFloat {
        return waterSource!.showLayoutView(self, w: w, indexPath: indexPath)
    }
    
    func numberOfColsInWaterfallLayout(_ layout: LXWaterfallLayout) -> Int {
        return waterSource!.showLayoutView(numberOfColsInWaterfallLayout: self)
    }
    
    
}
