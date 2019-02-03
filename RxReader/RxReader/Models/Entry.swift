//
//  Entry.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import Foundation

struct ResponseData: Codable {
    let data: [Entry]
}

struct Entry: Codable {
    let title: String
    let blogTitle: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case blogTitle = "blog_title"
        case link
    }
}
