//
//  UILabel+Extension.swift
//  FallingWords
//
//  Created by Osama Bashir on 8/16/20.
//  Copyright © 2020 Osama Bashir. All rights reserved.
//

import UIKit

extension UILabel {
    func setWidth(maxSize: CGSize = CGSize(width: 999, height: 100)) {
        let expectedSize = self.sizeThatFits(maxSize)
        self.frame.size.width = expectedSize.width
    }
}
