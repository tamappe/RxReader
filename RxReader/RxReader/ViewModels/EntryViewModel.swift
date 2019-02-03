//
//  EntryViewModel.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import RxSwift

final class EntryViewModel {
    
    let entries = PublishSubject<[Entry]>()

    let apiClient = EntryApiClient()
    
    func updateEntry() {
        apiClient.request { (entrys, error) in
            self.entries.onNext(entrys ?? [])
        }
    }
}
