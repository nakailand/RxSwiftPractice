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

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    var str = Variable("aa")
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = Observable.just([
            str
            ])

        items
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                element.asObservable().bindTo(cell.textLabel!.rx_text).addDisposableTo(self.disposeBag)
            }
            .addDisposableTo(disposeBag)


        tableView
            .rx_modelSelected(String)
            .subscribeNext { value in
                print(value)
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

