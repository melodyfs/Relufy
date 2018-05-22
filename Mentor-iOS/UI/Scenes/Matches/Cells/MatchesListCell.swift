//
//  MatchesListCell.swift
//  Mentor-iOS
//
//  Created by Melody on 3/29/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MatchesListCell: UICollectionViewCell {
    
    var viewModel: MessageItemViewModel! {
        didSet {
            nameLabel.text = viewModel?.name
            roleLabel.text = (viewModel?.role)! + " for \(viewModel.years) years"
            goalInputLabel.text = viewModel.goal
            if (viewModel?.image)! == "/image_files/original/missing.png" {
                profileImageView.image = UIImage(named: "profileImageHolder")
            } else {
//                profileImageView.getImageFromURL(url: (viewModel?.image)!)
                let url = URL(string: (viewModel?.image)!)
                profileImageView.kf.setImage(with: url)
                bgView.kf.setImage(with: url)
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.text = "About Me"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let goalInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
//        imageView.layer.cornerRadius =
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        photoHeight = frame.height/2.5
        setUpBackgroundView()
        setUpHeaders()
        setUpViews()
        profileImageView.layer.cornerRadius = photoHeight/2
        
    }
    
    var bgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.violetBlue.withAlphaComponent(0.5)
        view.addBlurEffect()
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var photoHeight: CGFloat!
    
    func setUpHeaders() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(roleLabel)
        
        
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: photoHeight).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: photoHeight).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
       

        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: photoHeight/5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor,  constant: photoHeight + 10).isActive = true
        
        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 20).isActive = true
        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
    }
    
    
   
    func setUpViews() {
        addSubview(goalLabel)
        addSubview(goalInputLabel)
        
        goalLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor, constant: 5).isActive = true
        goalLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: goalLabel.leftAnchor).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 0).isActive = true
        goalInputLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        goalInputLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
     
    }
    
    func setUpBackgroundView() {
        addSubview(bgView)
        bgView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 150)
        bgView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}





