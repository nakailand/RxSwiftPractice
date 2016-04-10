//
//  ButtonSampleViewController.swift
//  RxSwiftPractice
//
//  Created by nakazy on 2016/02/01.
//  Copyright © 2016年 nakazy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ButtonSampleViewController: UIViewController {
    
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    private var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Rx
        rxButton.rx_tap
            .take(5)
            .subscribeNext {
                print("rxButton tap")
            }
        .addDisposableTo(disposeBag)

        // Normal
        button.addTarget(self, action: #selector(ButtonSampleViewController.tap), forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tap() {
        if count >= 5 {
            return
        } else {
            print("button tap")
        }
        count += 1
    }
}


