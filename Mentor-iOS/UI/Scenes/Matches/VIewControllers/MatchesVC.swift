//
//  MatchesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class MatchesVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource = GenericCollectionViewDatasource<MessageItemViewModel>()
    let viewModel = MessageViewModel()
    let cellID = "matchesCell"
    var matchIDs = [Int]()
    let keychain = KeychainSwift()
    let keys = AppKeys.instance
    var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpEmptyView()
        viewModel.confirmed = ["confirmed": "false"]
        view.backgroundColor = UIColor.white
        registerCollectionView()
        
//        if viewModel.matchIDs.count == 0 {
////            emptyView.removeFromSuperview()
//            setUpEmptyView()
//        } else {
////            registerCollectionView()
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.matchIDs.count != 0 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
//            if view.superview != nil {
//                emptyView.removeFromSuperview()
//
//            }
           
        }
    }
    
    lazy var getStartedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Get Started by Completing Your Profile!"
        return label
    }()
    
    func setUpEmptyView() {
        emptyView = UIView()
        view.addSubview(emptyView)
        emptyView.addSubview(getStartedLabel)
        emptyView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 200)
        getStartedLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        getStartedLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        
    }
    
    func registerCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(MatchesListCell.self, forCellWithReuseIdentifier: cellID)
        flowLayout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        fetchUsers()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 200)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    func fetchUsers() {
        viewModel.fetchMatches(callback: { [unowned self] (users) in
            self.dataSource.items = users
            self.matchIDs = self.viewModel.matchIDs
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MatchesListCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            cell.connectButton.tag = self.matchIDs[indexPath.section]
            cell.connectButton.addTarget(self, action: #selector(self.handleConnect), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func handleConnect(sender: UIButton) {
        print("connect tapped")
        let otherPersonID = sender.tag
        let index = matchIDs.index(of: otherPersonID)
        var params = [String: String]()
        
        if keys.isMentor {
            params = ["mentor_id": keychain.get("id")!,
                          "mentee_id":"\(otherPersonID)",
                          "confirmed": "true" ]
        } else {
            params = ["mentor_id": "\(otherPersonID)",
                      "mentee_id": keychain.get("id")!,
                      "confirmed": "true" ]
        }
        
        ServerNetworking.shared.getInfo(route: .confirmMatched, params: params) { _ in}
        dataSource.items.remove(at: index!)
        self.collectionView.deleteSections([index!])
    }
    

}

extension MatchesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.row]
//        goToDetailController(selectedMemo: selectedMemo)
    }
    
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 10, height: frameSize.height)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}

