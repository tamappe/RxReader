//
//  UIColor+Extension.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/09.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // UIColor(255, 100, 0)
    convenience init(r red: Int, g green: Int, b blue: Int, a alpha: Int = 255) {
        let rgba = [red, green, blue, alpha].map { i -> CGFloat in
            switch i {
            case let i where i < 0:
                return 0
            case let i where i > 255:
                return 1
            default:
                return CGFloat(i) / 255
            }
        }
        self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
    
    // UIColor(rgb: 0xD9E5FF)
    convenience init(rgb: Int) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgb & 0x0000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(rgba: Int) {
        let r: CGFloat = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((rgba & 0x0000FF00) >>  8) / 255.0
        let a: CGFloat = CGFloat( rgba & 0x000000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

