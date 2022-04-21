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

    private lazy var label : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)
        btn.backgroundColor = .blue
        return btn
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
        label.gsm.all()
    }
    
    @objc func action(){
        print("Action")
        label.gsm.size(20)
    }
}

