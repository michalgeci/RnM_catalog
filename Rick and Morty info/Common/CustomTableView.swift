//
//  CustomTableView.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 20/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    
    var addedLoader = false
    var numberOfCells = 0
    
    // MARK: No more data variable, getter, setter
    private var noMoreData = false
    
    func setNoMoreData() {
        self.noMoreData = true
    }
    
    func resetNoMoreData() {
        self.noMoreData = false
    }
    
    // MARK: - Loading cell
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let nib = UINib(nibName: "LoadingTableCell", bundle: nil)
        self.register(nib, forCellReuseIdentifier: "LoadingTableCell")
    }
    
    func getLoadingCell(indexPath: IndexPath) -> LoadingTableCell {
        let cell = self.dequeueReusableCell(withIdentifier: "LoadingTableCell", for: indexPath) as! LoadingTableCell
        return cell
    }
    
    // MARK: - Help functions for datasource and delegate
    
    func getCorrectCell(indexPath: IndexPath, dataCount: Int, cellCreationClosure: () -> UITableViewCell) -> UITableViewCell {
        
        if indexPath.row < dataCount {
            let cell = cellCreationClosure()
            return cell
        } else {
            let cell = self.getLoadingCell(indexPath: indexPath)
            if self.noMoreData {
                cell.label.text = "No more data"
                cell.stopAnimation()
            } else {
                cell.startAnimation()
            }
            return cell
        }
        
    }
    
    func willDisplayCell(indexPath: IndexPath, dataCount: Int, appendDataClosure: @escaping ()->Void) {
        
        if indexPath.row + 1 == dataCount && !addedLoader {
            self.numberOfCells += 1
            self.addedLoader = true
            DispatchQueue.main.async {
                self.reloadData()
                if !self.noMoreData {
                    appendDataClosure()
                }
            }
        }
    }
    
    func afterAppendRequest(dataCount: Int) {
        self.numberOfCells = dataCount
        self.addedLoader = false
        self.reloadData()
    }

}
