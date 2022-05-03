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
        label.backgroundColor = .blue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    func configureUI(){
        label.gsm {
            $0.right.left.bottom.width.equalTo()
            $0.top.left.centerX.equalTo()
        }
    }
}

