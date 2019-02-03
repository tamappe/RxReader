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
    
    func updateEntry() {
        var sections: [Entry] = []
        sections.append(Entry.init(name: "test2"))
        sections.append(Entry.init(name: "test3"))
        sections.append(Entry.init(name: "test4"))
        entries.onNext(sections)
    }
}
