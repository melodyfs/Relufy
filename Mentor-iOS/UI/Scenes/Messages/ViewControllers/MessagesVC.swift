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
    var allChannels = [String]()
    var menteeUserInfo = [MessageItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.confirmed = ["confirmed": "true"]
        keys.setMentorOrMentee(isMentor: keys.isMentor)
        registerCollectionView()
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchMenteeMessages()
        fetchUsers()
        configureCell()
        addSegmentedControl()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keys.setMentorOrMentee(isMentor: keys.isMentor)
        self.tabBarController?.tabBar.isHidden = false
        configureCell()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    var customSC: UISegmentedControl!
    
    func addSegmentedControl() {
        let items = ["From Relators", "From Relatees"]
        customSC = UISegmentedControl(items: items)
        let normalFont = UIFont.systemFont(ofSize: 14)
        let normalTextAttributes: [NSObject : AnyObject] = [
            NSAttributedStringKey.font as NSObject: normalFont]
        customSC.backgroundColor = UIColor.clear
        customSC.tintColor = UIColor.violetBlue
        customSC.setTitleTextAttributes(normalTextAttributes, for: .normal)
        customSC.selectedSegmentIndex = 0
        customSC.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        customSC.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        navigationItem.titleView = customSC
    }

    
    var getMenteeMessages = false
    
    @objc func handleValueChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getMenteeMessages = false
            configureCell()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

        case 1:
            getMenteeMessages = true
            configureCell()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
        collectionView.isScrollEnabled = true
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screensize.width, height: screensize.height + 100)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
    }
    
    func fetchUsers() {
        if getMenteeMessages {
            viewModel.fetchMenteeMatches(callback: { (users) in
                self.menteeUserInfo = users
                self.dataSource.items = self.menteeUserInfo
                self.subToAllChatrooms()
                self.configureCell()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        } else {
            viewModel.fetchMatches(callback: { (users) in
                self.userInfo = users
                self.dataSource.items = self.userInfo
                self.subToAllChatrooms()
                self.configureCell()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
        

    }
    
    func fetchMenteeMessages() {
        viewModel.fetchMenteeMatches(callback: { (users) in
            self.menteeUserInfo = users
        })
    }
    
    func configureCell() {
        
        if getMenteeMessages {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.dataSource.items = self.menteeUserInfo
            }
            dataSource.configureCell = { cv, indexPath in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! MessageCell
                cell.viewModel = self.dataSource.items[indexPath.section]
                cell.addShadow()
        
                return cell
            }
            
            
        } else {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.dataSource.items = self.userInfo
            }
            dataSource.configureCell = { cv, indexPath in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! MessageCell
                cell.viewModel = self.dataSource.items[indexPath.section]
                cell.addShadow()
                
                return cell
            }
        }
        
        
        
       
    }
    
    func collectAllChannels() -> [String] {
        var allEmails = [String]()
        for i in 0..<userInfo.count {
            allEmails.append(userInfo[i].email)
        }
        
        var allChannels = [String]()
        for email in allEmails {
            var channel = setChannelName(email: email)
            allChannels.append(channel)
        }
        
        return allChannels
    }
    
    func collectAllMenteeChannels() -> [String] {
        var allEmails = [String]()
        for i in 0..<menteeUserInfo.count {
            allEmails.append(menteeUserInfo[i].email)
        }
        
        var allChannels = [String]()
        for email in allEmails {
            var channel = setChannelName(email: email)
            allChannels.append(channel)
        }
        
        return allChannels
    }
    
    func subToAllChatrooms() {
        allChannels = collectAllChannels()
        for channel in allChannels {
            subToChannel(channelName: channel)
            listenToMessages(channel: channel)
        }
        
        var allMenteeChannels = collectAllMenteeChannels()
        for channel in allMenteeChannels {
            subToChannel(channelName: channel)
            listenToMessages(channel: channel)
        }
    }
    
    let userEmail = KeychainSwift().get("email")
    
    func setChannelName(email: String) -> String {
        var channelName = ""
        if keys.isMentor {
            channelName = "private-\(userEmail!)-\(email)"
        } else {
            channelName = "private-\(email)-\(userEmail!)"
        }
        return channelName
    }
    
    func listenToMessages(channel: String) {
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
        
        let chan = pusher.subscribe(channel)
        let _ = chan.bind(eventName: "chat", callback: { data in
            print(data)
            if let data = data as? [String : AnyObject] {
                if let sender = data["sender"] as? String {
                    if let content = data["content"] as? String {
                        self.notifyNewMessage(title: sender, body: content)
//                        dataSource.configureCell = { cv, indexPath in
//                            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! MessageCell
//                            cell.viewModel = self.dataSource.items[indexPath.section]
//                            cell.addShadow()
//
//                            return cell
//                        }
                    }
                }
            }
        })
        
    }
    
    func notifyNewMessage(title: String, body: String) {
        var params = ["title": title,
                      "body": body]
        ServerNetworking.shared.getInfo(route: .postNotification, params: params) {_ in}
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

