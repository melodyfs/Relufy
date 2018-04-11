//
//  TableDataSource.swift
//  Mentor-iOS
//
//  Created by Melody on 3/31/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

typealias TableCellCallback = (UITableView, IndexPath) -> UITableViewCell

class TableDatasource<Item>: NSObject, UITableViewDataSource {
    var items: [Item]
    
    var configureCell: TableCellCallback?
    
    init(items: [Item]) {
        self.items = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let configureCell = configureCell else {
            fatalError("You did pass a configuration closure to configureCell, you must do so")
        }
        
        return configureCell(tableView, indexPath)
    }
}
