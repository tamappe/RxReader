//
//  UITableViewCell+Extension.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/09.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    @IBInspectable
    var selectedBackgroundColor: UIColor? {
        get {
            return selectedBackgroundView?.backgroundColor
        }
        set(color) {
            let background = UIView()
            background.backgroundColor = color
            selectedBackgroundView = background
        }
    }
    
}
