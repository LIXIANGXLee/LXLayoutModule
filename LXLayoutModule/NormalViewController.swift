//
//  NormalViewController.swift
//  LXLayoutModule
//
//  Created by XL on 2020/8/20.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit
import LXLayoutManager

class NormalViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.red
            
            let showLayoutView = LXShowLayoutView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), type: .vertical)
            
            showLayoutView.dataSource = self
            showLayoutView.delegate = self
            showLayoutView.isPagingEnabled =  true
            view.addSubview(showLayoutView)
            
            
        }


    }

extension NormalViewController: LXShowLayoutViewDelegate {
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, didSelectItemAt indexPath: IndexPath) {
        print("-=-=-=-=-=-=\(indexPath)")
        self.dismiss(animated: true, completion: nil)

    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 260)
    }
    
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.001
    }

    func showLayoutView(_ showLayoutView: LXShowLayoutView, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 375, height: 60)
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, referenceSizeForFooterInSection section: Int) -> CGSize {
                return CGSize(width: 375, height: 60)

    }
}

extension NormalViewController: LXShowLayoutViewDataSource {
    
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, numberOfSections collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, registerClass collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.register(ReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")

    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
                   return headerView

        }else{
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
                   return footerView

        }
       
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
}

class ReusableView: UICollectionReusableView {
    
}
