//
//  EntryViewModel.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

struct SectionOfEntry {
    var items: [Item]
}

extension SectionOfEntry: SectionModelType {
    typealias Item = Entry
    
    init(original: SectionOfEntry, items: [SectionOfEntry.Item]) {
        self = original
        self.items = items
    }
}

class EntryViewModel {
    
    let items = PublishSubject<[SectionOfEntry]>()
    
    func updateItem() {
        var sections: [SectionOfEntry] = []
        sections.append(SectionOfEntry(items: [SectionOfEntry.Item(name: "Nozaki"),
                                               SectionOfEntry.Item(name: "Sakura")]))
        items.onNext(sections)
    }
}
