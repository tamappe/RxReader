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
    
    let dataSource = BehaviorRelay(value: [Entry]())

    let apiClient = EntryApiClient()
    
    var isLoading = false
    
    var entries: [Entry] = []

    var currentPage = 0

    final let isAnimating = Variable(false)
    
    func updateEntry() {
        guard !isLoading else { return }
        isLoading = true
        isAnimating.value = true
        currentPage += 1
        let param = ["page": currentPage]
        apiClient.request(parameters: param as [String : AnyObject]) { (entrys, error) in
            self.isLoading = false
            self.isAnimating.value = false
            self.entries.append(contentsOf: entrys ?? [])
            self.dataSource.accept(self.entries)
        }
    }
    
    func insertEntries() {
        updateEntry()
    }
}
