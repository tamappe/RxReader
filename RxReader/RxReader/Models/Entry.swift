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
    enum CodingKeys: String, CodingKey {
        case data = "result_data"
    }
}

struct Entry: Codable {
    let title: String
    let published: String
    let linkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case published
        case linkUrl = "link_url"
    }
}
