//
//  PersonDetailVC.swift
//  Mentor-iOS
//
//  Created by Melody on 5/3/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import GrowingTextView

class PersonDetailVC: UIViewController, GrowingTextViewDelegate {
    
    var selectedUser = [MessageItemViewModel]()
    var userImage: UIImage!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.violetBlue
        label.text = "About Me"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalInputLabel: GrowingTextView = {
        let label = GrowingTextView()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    
    let companyInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.violetBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Company"
        return label
    }()
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.violetBlue
        label.text = "Race"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let raceInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.violetBlue
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message", for: .normal)
        button.backgroundColor = UIColor.violetBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(removeMessageButton), for: .touchUpInside)
        return button
    }()
    
    var isConfirmed = false
    
    @objc func removeMessageButton() {
        connectButton.removeFromSuperview()
//        startMessaging()
        matcheConfirmed()
        self.tabBarController?.selectedIndex = 1
        let conversationVC = ConversationVC()
        let messagesVC = self.tabBarController?.viewControllers?[1] as! UINavigationController
        conversationVC.userInfo = selectedUser
        messagesVC.pushViewController(conversationVC, animated: true)
       
    }
    
    func matcheConfirmed() {
        var params = [String: String]()
        let keys = AppKeys.instance
        
        if keys.isMentor {
            params = ["mentor_id": userID,
                      "mentee_id":"\(selectedUser.first!.id)",
                    "confirmed": "true" ]
        } else {
            params = ["mentor_id": "\(selectedUser.first!.id)",
                    "mentee_id": userID,
                    "confirmed": "true" ]
        }
        isConfirmed = true
        ServerNetworking.shared.getInfo(route: .confirmMatched, params: params) { _ in}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if isMovingFromParentViewController {
            if let viewControllers = self.navigationController?.viewControllers {
                if (viewControllers.count >= 1) {
                    let matchesVC = viewControllers[viewControllers.count-1] as! MatchesVC
                    if isConfirmed {
                        let otherPersonID = selectedUser.first!.id
                        let index = matchesVC.matchIDs.index(of: otherPersonID)
                        matchesVC.dataSource.items.remove(at: index!)
                        matchesVC.collectionView.deleteSections([index!])
                        print("confirmed")
                    }
                    
                }
            }
        }
    }
    
    
//    func startMessaging() {
//        let alertController = UIAlertController(title: "Start chatting!", message: "Go to Message to start a conversation now!", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "Ok", style: .default)
//        alertController.addAction(ok)
//        self.present(alertController, animated: true) { () in
//        }
//
//    }
    
    func setUpHeaders() {
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(roleLabel)
        
        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 70).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 50).isActive = true

        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true

    }
    
    func setUpMessageButton() {
        scrollView.addSubview(connectButton)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
//        connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: screensize.width).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        let tabBarHeight = CGFloat((tabBarController?.tabBar.frame.size.height)!)
        connectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight).isActive = true
       
        
    }
    
    func setUpViews() {
        view.backgroundColor = UIColor.white
        scrollView.addSubview(companyInputLabel)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(goalInputLabel)
        scrollView.addSubview(raceLabel)
        scrollView.addSubview(raceInputLabel)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderInputLabel)
        
        let itemWidth = screensize.width - 30
       
        goalLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        goalLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 240).isActive = true
        goalLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: goalLabel.leftAnchor, constant: -5).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 10).isActive = true
        goalInputLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
//        goalInputLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        companyLabel.anchor(top: goalInputLabel.bottomAnchor, left: goalLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 0)
        companyInputLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
        companyInputLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true


        raceLabel.leftAnchor.constraint(equalTo: companyInputLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: companyInputLabel.topAnchor, constant: 70).isActive = true
        raceLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        raceInputLabel.leftAnchor.constraint(equalTo: raceLabel.leftAnchor).isActive = true
        raceInputLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 20).isActive = true
        raceInputLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        
        genderLabel.leftAnchor.constraint(equalTo: raceInputLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceInputLabel.topAnchor, constant: 70).isActive = true
        genderLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
//        genderInputLabel.anchor(top: genderLabel.topAnchor, left: genderLabel.leftAnchor, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 30, paddingRight: 0, width: itemWidth, height: 50)
        genderInputLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        genderInputLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 20).isActive = true
//        genderInputLabel.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        genderInputLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let tabBarHeight = CGFloat((tabBarController?.tabBar.frame.size.height)!)
        genderInputLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -tabBarHeight - 65).isActive = true
        
    }
    
    var scrollView: UIScrollView!
    let screensize: CGRect = UIScreen.main.bounds
    
    func setUpScrollView() {
//        scrollView = UIScrollView()
//        view.addSubview(scrollView)
//        //        self.scrollView.contentSize = CGSize(width:screenWidth, height: screensize.height + 50)
//        scrollView.isScrollEnabled = true
//        //        self.scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screensize.height + 50)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView = UIScrollView()
        let screenWidth = screensize.width
        let height = screensize.height
//        self.scrollView.contentSize = CGSize(width:screenWidth, height: height + 50)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
    }
    
    
    func setValues() {
        
        if (selectedUser.first?.image)! == "/image_files/original/missing.png" {
            profileImageView.image = UIImage(named: "profileImageHolder")
           
        } else {
//            profileImageView.getImageFromURL(url: (selectedUser.first?.image)!)
            let url = URL(string:(selectedUser.first?.image)!)
            profileImageView.kf.setImage(with: url)
        }
        
        userImage = profileImageView.image
        nameLabel.text = (selectedUser.first!.name)
        roleLabel.text = selectedUser.first!.role + " for \((selectedUser.first!.years)) years"
        goalInputLabel.text = selectedUser.first?.goal
        companyInputLabel.text = selectedUser.first?.company
        raceInputLabel.text = selectedUser.first?.race
        genderInputLabel.text = selectedUser.first?.gender
    }
    
    func setUpBackground() {
        let bgView = UIImageView()
//        bgView.getImageFromURL(url: UserDefaults.standard.string(forKey: "image")!)
//        bgView.image = userImage
        let url = URL(string:(selectedUser.first?.image)!)
        bgView.kf.setImage(with: url)
        bgView.addBlurEffect()
        bgView.backgroundColor = UIColor.violetBlue.withAlphaComponent(0.5)
        
        scrollView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        bgView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        setValues()
        setUpBackground()
        setUpHeaders()
        setUpViews()
        setUpMessageButton()
        navigationController?.navigationBar.prefersLargeTitles = false
        addBottomBorders()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        addBottomBorders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addBottomBorders()
    }
    
    
    func addBottomBorders() {
        companyLabel.layer.addBorder(edge: .top, color: UIColor.violetBlue, thickness: 0.5)
        raceLabel.layer.addBorder(edge: .top, color: UIColor.violetBlue, thickness: 0.5)
        genderLabel.layer.addBorder(edge: .top, color: UIColor.violetBlue, thickness: 0.5)
    }
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addTopBorderWithColor(_ objView : UILabel, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: objView.frame.size.width, height: width)
        objView.layer.addSublayer(border)
    }

}
