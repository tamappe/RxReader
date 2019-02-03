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
    
    private var viewModel = EntryViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableViewOptions()
        
        viewModel.entries
            .bind(to: tableView.rx.items(cellIdentifier:"EntryTableViewCell")) { _, entry, cell in
                if let cell = cell as? EntryTableViewCell {
                    cell.configureCell(entry: entry)
                }
            }.disposed(by:disposeBag)
        viewModel.updateEntry()
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableView.cellForRow(at: indexPath) as? EntryTableViewCell
                let storyboard = UIStoryboard(name: "DetailPage", bundle: nil)
                guard let detailPageVC = storyboard.instantiateInitialViewController() as? DetailPageViewController
                    else { return }
                detailPageVC.urlString = cell?.urlString
                self?.navigationController?.pushViewController(detailPageVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

extension MainViewController {
    private func setupViewController() {
        self.title = "トップ画面"
    }
    
    private func setupTableViewOptions() {
        let nib = UINib(nibName: "EntryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EntryTableViewCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}
