//
//  UIButton+Extension.swift
//  Mentor-iOS
//
//  Created by Melody on 4/8/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

extension UIButton {
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
    func makeRounded() {
        layer.cornerRadius = 7
//        clipsToBounds = true
    }
    
    func addBorder(color: UIColor) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
