//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by nakazy on 2016/01/24.
//  Copyright © 2016年 nakazy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var rxLabel: UILabel!
    @IBOutlet weak var textFieldSampleButton: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableViewSampleButton: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        button.rx_tap
            .subscribeNext {
                let buttonSampleViewController = UIStoryboard(name: "ButtonSample", bundle: nil).instantiateInitialViewController()

                self.navigationController?.pushViewController(buttonSampleViewController!, animated: true)
            }
            .addDisposableTo(disposeBag)
        
        textFieldSampleButton.rx_tap
            .subscribeNext {
                let textFieldSampleViewController = UIStoryboard(name: "TextFieldSample", bundle: nil).instantiateInitialViewController() as! TextFieldSampleViewController

                textFieldSampleViewController.text
                    .asObservable()
                    .subscribeNext { [unowned self] text in
                        self.rxLabel.text = text
                    }
                    .addDisposableTo(self.disposeBag)

                self.navigationController?.pushViewController(textFieldSampleViewController, animated: true)
            }
            .addDisposableTo(disposeBag)
        
        tableViewSampleButton.rx_tap
            .subscribeNext {
                let tableViewSampleViewController = UIStoryboard(name: "TableViewSample", bundle: nil).instantiateInitialViewController()
                self.navigationController?.pushViewController(tableViewSampleViewController!, animated: true)
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

