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

struct Person{
    let name : String
    let age : Int
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var personArr = [Person(name: "satish",age: 30),Person(name: "naresh",age: 28),Person(name: "lokesh",age: 40),Person(name: "nani",age: 25),Person(name: "hari",age: 30)]
    
    var objectArr : Observable<[Person]>?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "EntryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EntryTableViewCell")

        objectArr = Observable.just(personArr)
        
        objectArr?.bind(to: tableView.rx.items(cellIdentifier:"EntryTableViewCell")){
            _,person, cell in
            if let cellToUse = cell as? EntryTableViewCell {
                cellToUse.textLabel?.text = person.name
                print(person.name)
            }
            }.disposed(by:disposeBag)
    }
}

