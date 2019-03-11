//
//  ViewController.swift
//  MVVMDemo
//
//  Created by wu ning on 2019/3/10.
//  Copyright © 2019 allen. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var pushButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pushButton.rx.tap.subscribe(onNext:{ [weak self] in
            let vc = LoginViewcontroller()
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
    }
}

