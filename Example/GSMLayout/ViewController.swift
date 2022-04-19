//
//  ViewController.swift
//  GSMLayout
//
//  Created by ahnjh1028@naver.com on 04/14/2022.
//  Copyright (c) 2022 ahnjh1028@naver.com. All rights reserved.
//

import UIKit
import GSMLayout

class ViewController: UIViewController {

    private let label : UILabel = {
        let label = UILabel()
        label.text = "라벨"
        label.backgroundColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.gsm.size(100%)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

