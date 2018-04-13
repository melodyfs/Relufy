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
    var userInfo = [MessageItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.confirmed = ["confirmed": "false"]
        view.backgroundColor = UIColor.white
        registerCollectionView()
        setNameAndImage()
        navigationController?.navigationBar.prefersLargeTitles = true
         print(userInfo.count)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ServerNetworking.shared.getInfo(route: .createMatches, params: [:]) {_ in}
       fetchUsers()
    }
    
    var getStartedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Complete Your Profile & Check Back Soon!"
        return label
    }()
    
    func setUpBgLabel() {
        collectionView.addSubview(getStartedLabel)
        getStartedLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        getStartedLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        
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
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 200)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    func fetchUsers() {
        viewModel.fetchMatches(callback: { [unowned self] (users) in
            self.dataSource.items = users
            self.userInfo = users
            self.matchIDs = self.viewModel.matchIDs
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
       configureCell()
    }
    
    func configureCell() {
        
        if self.dataSource.items.count == 0 {
            self.collectionView.setEmptyMessage("Complete Your Profile & Check Back Soon!")
            self.collectionView.setImageView(UIImage(named: "matches")!)
        }
        
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MatchesListCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            cell.connectButton.tag = self.matchIDs[indexPath.section]
            cell.connectButton.addTarget(self, action: #selector(self.handleConnect), for: .touchUpInside)
            cell.addShadow()
            cell.roundCorner()
            let frameSize = self.collectionView.frame.size
            cell.scrollView.frame = CGRect(x: 0, y: 0, width: frameSize.width - 20, height: frameSize.height - 120)
            cell.scrollView.contentSize = CGSize(width: frameSize.width - 20, height: 650)
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
    
    func setNameAndImage() {
        if AppKeys.instance.isMentor {
            ServerNetworking.shared.getInfo(route: .getMentorImage, params: [:]) { info in
                if let userinfo = try? JSONDecoder().decode([User].self, from: info) {
                    UserDefaults.standard.set((userinfo.first?.image_file)!, forKey: "image")
                    UserDefaults.standard.set(userinfo.first?.name, forKey: "name")
                }
            }
        } else {
            ServerNetworking.shared.getInfo(route: .getMenteeImage, params: [:]) { info in
                if let userinfo = try? JSONDecoder().decode([User].self, from: info){
                    UserDefaults.standard.set((userinfo.first?.image_file)!, forKey: "image")
                    UserDefaults.standard.set(userinfo.first?.name, forKey: "name")
                }
            }
        }
        
    }
    

}

extension MatchesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.row]
    }
    
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 20, height: frameSize.height - 120)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}



