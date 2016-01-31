//
//  ButtonViewController.swift
//  RxSwiftPractice
//
//  Created by nakazy on 2016/02/01.
//  Copyright © 2016年 nakazy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ButtonViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        button.rx_tap
            .subscribeNext {
                print("tap")
            }
        .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


