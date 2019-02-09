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
    
    static let startLoadingOffset: CGFloat = 20.0
    
    static func isNearTheBottomEdge(contentOffset: CGPoint, _ tableView: UITableView) -> Bool {
        return contentOffset.y + tableView.frame.size.height + startLoadingOffset > tableView.contentSize.height
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = EntryViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
        setupViewController()
        setupTableViewOptions()
        
        viewModel.entries
            .filter{ !$0.isEmpty }
            .bind(to: tableView.rx.items(cellIdentifier:"EntryTableViewCell")) { index, entry, cell in
                if let cell = cell as? EntryTableViewCell {
                    cell.configureCell(entry: entry, row: index)
                }
            }
            .disposed(by:disposeBag)
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
    
        tableView.rx.contentOffset
            .flatMap { offset -> Observable<Void> in
            return MainViewController.isNearTheBottomEdge(contentOffset: offset, self.tableView) ? Observable.just(()) : Observable.empty()
            }
            .filter{ !self.viewModel.isLoading }
            .subscribe(onNext: {
                // TODO: 本当はこんな処理はしないが便宜上
                self.viewModel.insertEntries()
            })
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { cellInfo in
                let (cell, indexPath) = cellInfo
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = UIColor(rgb: 0xe2e0e0)
                }
            })
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
