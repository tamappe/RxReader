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
    
    let isLoading = BehaviorRelay(value: false)
    
    private let apiClient = EntryApiClient()
    
    private var localEntries: [Entry] = []

    private var currentPage = 0
    
    func updateEntry() {
        guard !isLoading.value else { return }
        isLoading.accept(true)
        currentPage += 1
        let param = ["page": currentPage]
        apiClient.request(parameters: param as [String : AnyObject]) { (entries, error) in
            self.isLoading.accept(false)
            self.localEntries.append(contentsOf: entries ?? [])
            self.dataSource.accept(self.localEntries)
        }
    }
    
    func insertEntries() {
        updateEntry()
    }
}
