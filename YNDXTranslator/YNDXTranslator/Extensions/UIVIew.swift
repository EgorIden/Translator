//
//  UIVIew.swift
//  YNDXTranslator
//
//  Created by Egor on 01/02/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import UIKit
extension UIView {
    func styling() {
        self.clipsToBounds = false
        self.layer.cornerRadius = 8.0
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowRadius = 8.0
    }
}
