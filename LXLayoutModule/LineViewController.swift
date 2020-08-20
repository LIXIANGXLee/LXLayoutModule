//
//  ViewController.swift
//  LXLayoutModule
//
//  Created by XL on 2020/8/20.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit
import LXLayoutManager

class LineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let showLayoutView = LXShowLayoutView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 200), type: .lineFlow)
        
        showLayoutView.dataSource = self
        showLayoutView.delegate = self
        view.addSubview(showLayoutView)
        
        
    }


}

extension LineViewController: LXShowLayoutViewDelegate {
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, didSelectItemAt indexPath: IndexPath) {
        print("-=-=-=-=-=-=\(indexPath)")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 260, height: 160)
    }
    
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.001
    }
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.001
    }

}

extension LineViewController: LXShowLayoutViewDataSource {
    
    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, registerClass collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

    }

    
    func showLayoutView(_ showLayoutView: LXShowLayoutView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
}
