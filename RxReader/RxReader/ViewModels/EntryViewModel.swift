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
    
    func updateEntry() {
        isLoading = true
        apiClient.request { (entrys, error) in
            self.isLoading = false
            self.dataSource.append(contentsOf: entrys ?? [])
            self.entries.onNext(self.dataSource)
        }
    }
    
    func insertEntries() {
        isLoading = true
        apiClient.request { (entrys, error) in
            self.isLoading = false
            self.dataSource.append(contentsOf: entrys ?? [])
            self.entries.onNext(self.dataSource)
        }
    }
}
