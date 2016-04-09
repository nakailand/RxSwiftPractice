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
    @IBOutlet weak var rxTextField: UITextField!
    @IBOutlet weak var rxLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var rxUserNameField: UITextField!
    @IBOutlet weak var rxPasswordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var button: UIButton!
    private let helloString = "hello"
    private var userName = ""
    private var password = ""
    enum TextFieldType {
        case userNameTextField, passwordTextField
    }
    
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // RxのBind
        rxTextField
            .rx_text
            .skip(1)
            .bindTo(rxLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        // Bind
        textField.delegate = self
        
        NSNotificationCenter.defaultCenter().rx_notification(UIKeyboardWillShowNotification, object: nil)
            .subscribeNext { notification in
                guard let userInfo = notification.userInfo, keyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                    return
                }
                print(keyboardRect.CGRectValue())
            }
            .addDisposableTo(disposeBag)
        
        // Rxの文字一致チェック
        rxTextField
            .rx_text
            .filter { [unowned self] in
                $0 == self.helloString
            }
            .subscribeNext {
                print($0)
            }
            .addDisposableTo(disposeBag)
        
        // Rxのユーザー名、パスワードの文字数チェック
        Observable.combineLatest(rxUserNameField.rx_text, rxPasswordField.rx_text) { (userName, password) in
            return userName.characters.count > 5 && password.characters.count > 5
            }
            .subscribeNext { [unowned self] enabled in
                self.rxButton.enabled = enabled
            }
            .addDisposableTo(disposeBag)
        
        // ユーザー名、パスワードの文字数チェック
        userNameField.delegate = self
        passwordTextField.delegate = self
        userNameField.tag = TextFieldType.userNameTextField.hashValue
        passwordTextField.tag = TextFieldType.passwordTextField.hashValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TextFieldSampleViewController: UITextFieldDelegate {
        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            
            let text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            // Bind
            label.text = text
            
            // 文字一致チェック
            if text == helloString {
                print(helloString)
            }
            
            // ユーザー名、パスワードの文字数チェック
            switch textField.tag {
            case TextFieldType.userNameTextField.hashValue:
                userName = text
            case TextFieldType.passwordTextField.hashValue:
                password = text
            default: break
            }
            // ユーザー名、パスワードの文字数チェック
            button.enabled = userName.characters.count > 5 && password.characters.count > 5
            return true
        }
}


