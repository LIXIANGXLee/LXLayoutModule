//
//  MainViewController.swift
//  LXLayoutModule
//
//  Created by XL on 2020/8/20.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func lineAction(_ sender: Any) {
        
        self.present(LineViewController(), animated: true, completion: nil)
    }
    
    @IBAction func waterAction(_ sender: Any) {
        self.present(WaterViewController(), animated: true, completion: nil)

    }
    @IBAction func narmalAction(_ sender: Any) {
        self.present(NormalViewController(), animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
