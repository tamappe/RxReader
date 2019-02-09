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
    let id: Int
    let blogTitle: String
    let title: String
    let published: String
    let linkUrl: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case blogTitle = "blog_title"
        case title
        case published
        case linkUrl = "link"
        case imageUrl = "image"
    }
}
