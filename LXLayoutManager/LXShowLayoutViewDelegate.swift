//
//  LXShowLayoutView+Delegate.swift
//  LXLayoutModule
//
//  Created by XL on 2020/8/20.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit


//MARK: - LXShowLayoutViewDelegate
@objc public protocol LXShowLayoutViewDelegate: AnyObject {
    
   /// 布局item 大小
   @objc optional func showLayoutView(_ showLayoutView: LXShowLayoutView,  sizeForItemAt indexPath: IndexPath) -> CGSize
    
    /// 头的大小
    @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView,  referenceSizeForHeaderInSection section: Int) -> CGSize
    
    /// 尾的大小
    @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView,  referenceSizeForFooterInSection section: Int) -> CGSize

    ///列最小线间距
    @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    ///行最小线间距
    @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView, minimumLineSpacingForSectionAt section: Int) -> CGFloat

    /// 事件点击
    @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView,didSelectItemAt indexPath: IndexPath)

    
}


@objc public protocol LXShowLayoutViewDataSource: AnyObject {
    
    /// 需要注册的UICollectionViewCell
    func showLayoutView(_ showLayoutView: LXShowLayoutView, registerClass collectionView: UICollectionView)
       
    /// cell
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    /// cell 个数
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
     /// cell 组数
     @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView, numberOfSections collectionView: UICollectionView) -> Int
    
    /// 头 尾 的view
    @objc optional  func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView

}

//MARK: - LXShowLayoutViewWater  只有瀑布流才会用到
@objc public protocol LXShowLayoutViewWaterSource: AnyObject {
    
    /// 瀑布流高度
    func showLayoutView(_ showLayoutView: LXShowLayoutView,w: CGFloat, indexPath: IndexPath) -> CGFloat
    
    /// 瀑布流列数
    func showLayoutView(numberOfColsInWaterfallLayout showLayoutView: LXShowLayoutView) -> Int


}
