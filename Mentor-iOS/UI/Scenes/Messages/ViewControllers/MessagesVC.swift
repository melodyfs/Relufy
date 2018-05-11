//
//  MessagesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import PusherSwift
import KeychainSwift

class MessagesVC: UIViewController, PusherDelegate {
    
    var collectionView: UICollectionView!
    var pusher: Pusher!
    var dataSource = GenericCollectionViewDatasource<MessageItemViewModel>()
    var viewModel = MessageViewModel()
    var userInfo = [MessageItemViewModel]()
    let cell = "messageCell"
    let keys = AppKeys.instance
    var channelName = ""
    lazy var appDelegate = AppDelegateViewModel.instance
    let userDefault = UserDefaults.standard
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.confirmed = ["confirmed": "true"]
//        keys.setMentorOrMentee(isMentor: false)
        keys.setMentorOrMentee(isMentor: keys.isMentor)
//        fetchUsers()
        registerCollectionView()
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Inbox"
//        addSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keys.setMentorOrMentee(isMentor: keys.isMentor)
        self.tabBarController?.tabBar.isHidden = false
        DispatchQueue.main.async {
//            self.fetchUsers()
            self.collectionView.reloadData()
        }
        
    
    }
    
    func addSegmentedControl() {
        let items = ["Mentors", "Mentees"]
        let customSC = UISegmentedControl(items: items)
        let normalFont = UIFont.systemFont(ofSize: 16)
        let normalTextAttributes: [NSObject : AnyObject] = [
            NSAttributedStringKey.font as NSObject: normalFont]
        customSC.backgroundColor = UIColor.clear
        customSC.tintColor = UIColor.violetBlue
        customSC.setTitleTextAttributes(normalTextAttributes, for: .normal)
        customSC.selectedSegmentIndex = userDefault.integer(forKey: "segNum")
        customSC.frame = CGRect(x: 0, y: 0, width: 400, height: 40)
        customSC.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        navigationItem.title = nil
        navigationItem.titleView = customSC
    }
    
    @objc func handleValueChange(sender: UISegmentedControl) {
        collectionView.dataSource = nil
        switch sender.selectedSegmentIndex {
        case 0:
            keys.setMentorOrMentee(isMentor: false)
//            appDelegate.changeStatus(authStatus: .authorized)
            userDefault.set(0, forKey: "segNum")
            print("value change")
        case 1:
            keys.setMentorOrMentee(isMentor: true)
//            appDelegate.changeStatus(authStatus: .authorized)
            userDefault.set(1, forKey: "segNum")
            print("value change")
        default:
            break
        }
        
    }
    
    let screensize: CGRect = UIScreen.main.bounds
    
    func registerCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cell)
        flowLayout.scrollDirection = .vertical
//        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        fetchUsers()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screensize.width, height: screensize.height + 100)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
    }
    
    func fetchUsers() {
        viewModel.fetchMatches(callback: { (users) in
            self.dataSource.items = users
            self.userInfo = users
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        configureCell()
    }
    func configureCell() {
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! MessageCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            cell.addShadow()
            
            return cell
        }
    }
    
    func subToChannel(channelName: String) {
        let options = PusherClientOptions(
            authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),
            host: .cluster(cluster)
        )
        pusher = Pusher(
            key: key,
            options: options
        )
        pusher.delegate = self
        pusher.connect()
        
        let chan = pusher.subscribe(channelName)
    }
}

extension MessagesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.section]
        let chatRoomVC = ConversationVC()
        let userEmail = KeychainSwift().get("email")
        let otherPersonEmail = dataSource.items[indexPath.section].email
        
        chatRoomVC.userInfo = [selectedUser]
        chatRoomVC.otherPersonEmail = otherPersonEmail
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: 100)
        
    }
    
}

