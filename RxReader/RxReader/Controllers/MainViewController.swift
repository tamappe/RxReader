//
//  ViewController.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: EntryViewModel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewOptions()
        setupViewModel()
    }
}

extension MainViewController {
    private func setupViewController() {
//        self.title = "タイトル"
    }
    
    private func setupTableViewOptions() {
        let nib = UINib(nibName: "EntryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EntryTableViewCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupViewModel() {
        viewModel = EntryViewModel()
        
        viewModel.entries
            .bind(to: tableView.rx.items(cellIdentifier:"EntryTableViewCell")) { _, entry, cell in
                if let cellToUse = cell as? EntryTableViewCell {
                    cellToUse.configureCell(entry: entry)
                }
            }.disposed(by:disposeBag)
        viewModel.updateEntry()
    }
}
