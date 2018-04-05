//
//  MessagesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import PusherSwift

class MessagesVC: UIViewController, PusherDelegate {
    
    var collectionView: UICollectionView!
    var pusher: Pusher!
    var dataSource = GenericCollectionViewDatasource<MessageItemViewModel>()
    var viewModel = MessageViewModel()
    var userInfo = [MessageItemViewModel]()
    let cell = "messageCell"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        tabBarController?.tabBar.isHidden = false
//        createChatRoom()
//        createChatRooms()
//        let options = PusherClientOptions(
//            authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),
//            host: .cluster(cluster)
//        )
//        pusher = Pusher(
//            key: key,
//            options: options
//        )
//        pusher.delegate = self
//        pusher.connect()
//
//        //        let chan = pusher.subscribe("private-\(mentorEmail)-\(menteeEmail)")
//        let chan = pusher.subscribe("private-u")
//
//        let _ = chan.bind(eventName: "test", callback: { data in
//            print(data)
//            //            let _ = self.pusher.subscribe("private-\(mentorEmail)-\(menteeEmail)")
//            let _ = self.pusher.subscribe("private-u")
//            if let data = data as? [String : AnyObject] {
//                if let testVal = data["message"] as? String {
//                    print(testVal)
//                }
//            }
//        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
//            self.collectionView.reloadData()
        }
       
//        subToChannel(mentorEmail: "", menteeEmail: "")
//        connectPusher()
//        createChatRooms()
//        chan.trigger(eventName: "client-test", data: ["test": "some value"])
    }
    
    //Send a message thru server
    func connectPusher() {
        ServerNetworking.shared.getInfo(route: .sendMessage, params: ["channel_name": "private-u", "message": "test ios", "event": "test"]  ) { _ in }
        
    }
    
    func registerCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cell)
        flowLayout.scrollDirection = .vertical
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        fetchUsers()
//        createChatRooms()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 300)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        createChatRooms()
        
    }
    
    func fetchUsers() {
        viewModel.fetchMatches(callback: { [unowned self] (users) in
            self.dataSource.items = users
            self.userInfo = users
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })

        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! MessageCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            return cell
        }
    }
    
    // TODO: call this when 'Confirmed' is true
    func createChatRooms() {
        for i in userInfo {
            subToChannel(mentorEmail: i.email, menteeEmail: "mentee@test.com")
        }
    }
    
    func subToChannel(mentorEmail: String, menteeEmail: String) {
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
        
//        let chan = pusher.subscribe("private-\(mentorEmail)-\(menteeEmail)")
        let chan = pusher.subscribe("private-u")
        
        let _ = chan.bind(eventName: "test", callback: { data in
            print(data)
//            let _ = self.pusher.subscribe("private-\(mentorEmail)-\(menteeEmail)")
             let _ = self.pusher.subscribe("private-u")
            if let data = data as? [String : AnyObject] {
                if let testVal = data["message"] as? String {
                    print(testVal)
                }
            }
        })
        
    }
    
    func goToChatRoom(selectedPerson: MessageItemViewModel) {
        let chatRoomVC = ConversationVC()
        chatRoomVC.userInfo = userInfo
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
}

extension MessagesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.section]
        let chatRoomVC = ConversationVC()
        chatRoomVC.userInfo = [selectedUser]
        chatRoomVC.otherPersonEmail = dataSource.items[indexPath.section].email
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
//        goToChatRoom(selectedPerson: selectedUser)
    }
    
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: 100)
        
    }
    
}

