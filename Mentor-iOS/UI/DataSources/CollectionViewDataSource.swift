//
//  MatchesListDataSource.swift
//  Mentor-iOS
//
//  Created by Melody on 3/29/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

typealias CollectionViewCellCallback = (UICollectionView, IndexPath) -> UICollectionViewCell

class GenericCollectionViewDatasource<T>: NSObject, UICollectionViewDataSource {
    var items: [T] = []
    var configureCell: CollectionViewCellCallback?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let configureCell = configureCell else {
            fatalError("You did not pass a configuration closure to configureCell, you must do so")
            
        }
        
        return configureCell(collectionView, indexPath)
    }
    
}
