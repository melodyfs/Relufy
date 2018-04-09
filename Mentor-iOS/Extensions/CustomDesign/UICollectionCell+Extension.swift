//
//  UICollectionCell+Extension.swift
//  Mentor-iOS
//
//  Created by Melody on 4/8/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func addShadow() {
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
        layer.shadowRadius = 2.0;
        layer.shadowOpacity = 2.0;
        layer.masksToBounds = false;
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func roundCorner() {
        layer.cornerRadius = 6
    }
}


extension CALayer {
    public func configureGradientBackground(firstColors:CGColor, secondColor: CGColor){
        
        let gradient = CAGradientLayer()
        
        let maxWidth = max(self.bounds.size.height,self.bounds.size.width)
        let squareFrame = CGRect(origin: self.bounds.origin, size: CGSize(width: maxWidth, height: maxWidth))
        gradient.frame = squareFrame
        
        gradient.colors = [firstColors, secondColor]
        
        self.insertSublayer(gradient, at: 0)
    }
}
