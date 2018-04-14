//
//  CollectionView+Extension.swift
//  Mentor-iOS
//
//  Created by Melody on 4/11/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func setImageView(_ image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
//        imageView.image?.scale = CGRect(width: 100, height: 100)
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
//        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.backgroundView = imageView
    }
}
