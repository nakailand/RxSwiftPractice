//
//  TextFieldSampleViewController.swift
//  RxSwiftPractice
//
//  Created by nakazy on 2016/02/01.
//  Copyright © 2016年 nakazy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldSampleViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        textField
            .rx_text
            .bindTo(label.rx_text)
            .addDisposableTo(disposeBag)
        
        NSNotificationCenter.defaultCenter().rx_notification(UIKeyboardWillShowNotification, object: nil)
            .subscribeNext { notification in
                guard let userInfo = notification.userInfo, keyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                    return
                }
                print(keyboardRect.CGRectValue())
            }
            .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


