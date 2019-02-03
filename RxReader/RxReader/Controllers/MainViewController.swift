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
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "EntryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EntryTableViewCell")
        setupViewModel()
    }
}

extension MainViewController {
    private func setupViewController() {
//        self.title = "タイトル"
    }
    private func setupViewModel() {
        viewModel = EntryViewModel()
        
        viewModel.entries
            .bind(to: tableView.rx.items(cellIdentifier:"EntryTableViewCell")) { indexPath, person, cell in
                if let cellToUse = cell as? EntryTableViewCell {
                    cellToUse.textLabel?.text = person.name
                    print(person.name)
                }
            }.disposed(by:disposeBag)
        viewModel.updateEntry()
    }
}
