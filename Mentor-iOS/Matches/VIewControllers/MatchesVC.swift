//
//  MatchesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit

class MatchesVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource = GenericCollectionViewDatasource<MessageItemViewModel>()
    let viewModel = MessageViewModel()
    let cellID = "matchesCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MatchesListCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            return cell
        }
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

