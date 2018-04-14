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
            roleLabel.text = (viewModel?.role)! + " for \(viewModel.years) year(s)"
            companyInputLabel.text = (viewModel?.company)!
            goalInputLabel.text = viewModel.goal
            profileImageView.getImageFromURL(url: (viewModel?.image)!)
            bgView.getImageFromURL(url: (viewModel?.image)!)
            raceInputLabel.text = viewModel.race
            genderInputLabel.text = viewModel.gender
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Reason I am in Tech"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let companyInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Company"
        return label
    }()
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Race"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let raceInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let connectButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Connect", for: .normal)
        button.backgroundColor = UIColor.violetBlue
        button.addShadow()
        button.makeRounded()
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    @objc func touchDown(sender: UIButton) {
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.violetBlue, for: UIControlState.normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScrollView()
        setUpViews()
        setUpBackgroundView()
        setUpHeaders()
    }
    
    var bgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.violetBlue.withAlphaComponent(0.5)
        view.addBlurEffect()
        return view
    }()
    
    var scrollView: UIScrollView!
    
    func setUpScrollView() {
        scrollView = UIScrollView()
//        let screensize: CGRect = UIScreen.main.bounds
//        let screenWidth = screensize.width
//        scrollView.contentSize = CGSize(width: screenWidth, height: 900)
        scrollView.isScrollEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
    }
    
    func setUpHeaders() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(roleLabel)
        addSubview(connectButton)
        
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 80).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.bottomAnchor.constraint(equalTo:  scrollView.bottomAnchor, constant: -20).isActive = true
        connectButton.centerXAnchor.constraint(equalTo:  scrollView.centerXAnchor).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
   
    func setUpViews() {
        scrollView.addSubview(companyInputLabel)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(goalInputLabel)
        scrollView.addSubview(raceLabel)
        scrollView.addSubview(raceInputLabel)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderInputLabel)
        
        companyLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 220, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        companyInputLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
        
        goalLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 280).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: goalLabel.leftAnchor).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 20).isActive = true
        
        raceLabel.leftAnchor.constraint(equalTo: goalInputLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: goalInputLabel.topAnchor, constant: 70).isActive = true
        raceInputLabel.leftAnchor.constraint(equalTo: raceLabel.leftAnchor).isActive = true
        raceInputLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 20).isActive = true
        
        genderLabel.leftAnchor.constraint(equalTo: raceInputLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceInputLabel.topAnchor, constant: 40).isActive = true
        genderInputLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        genderInputLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 20).isActive = true
     
    }
    
    func setUpBackgroundView() {
        scrollView.addSubview(bgView)
        bgView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 210)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}





