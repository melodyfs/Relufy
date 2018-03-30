//
//  MatchesListCell.swift
//  Mentor-iOS
//
//  Created by Melody on 3/29/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MatchesListCell: UICollectionViewCell {
    
    var name: UILabel!
    var role: UILabel!
    var company: UILabel!
    var images: UIImageView!
    
    var viewModel: UserItemViewModel? {
        didSet {
            name.text = viewModel?.name
            role.text = viewModel?.role
            company.text = viewModel?.company
            images.getImageFromURL(url: (viewModel?.image)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    func setUpViews() {
        backgroundColor = UIColor.red
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
