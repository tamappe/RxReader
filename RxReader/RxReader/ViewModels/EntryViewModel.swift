//
//  EntryViewModel.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EntryViewModel {
    
    let entries = PublishSubject<[Entry]>()

    let apiClient = EntryApiClient()
    
    var isLoading = false
    
    var dataSource: [Entry] = []

    var currentPage = 0
    
    func updateEntry() {
        guard !isLoading else { return }
        isLoading = true
        currentPage += 1
        let param = ["page": currentPage]
        apiClient.request(parameters: param as [String : AnyObject]) { (entrys, error) in
            self.isLoading = false
            self.dataSource.append(contentsOf: entrys ?? [])
            self.entries.onNext(self.dataSource)
        }
    }
    
    func insertEntries() {
        updateEntry()
    }
}
