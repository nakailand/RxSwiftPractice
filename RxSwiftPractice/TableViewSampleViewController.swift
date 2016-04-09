//
//  TableViewSampleViewController.swift
//  RxSwiftPractice
//
//  Created by nakazy on 2016/02/06.
//  Copyright © 2016年 nakazy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TableViewSampleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item",
        ])
        
        items
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected
            .subscribeNext { [unowned self] in
                let cell = self.tableView.cellForRowAtIndexPath($0)
                print(cell?.textLabel?.text)
        }
        .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


