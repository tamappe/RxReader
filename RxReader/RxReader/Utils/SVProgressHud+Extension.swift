//
//  SVProgressHud+Extension.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/13.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: SVProgressHUD {
    
    public static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) {progressHUD, isVisible in
            if isVisible {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}
