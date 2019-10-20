//
//  LocationsVC.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 18/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit
import Alamofire

class LocationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topSeparatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: CustomTableView!
    
    var data: [RMLocation] = []
    var filter = RMLocationFilter(page: nil, name: nil, type: nil, dimension: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSeparatorHeightConstraint.constant = 0.5
        
        tableView.delegate = self
        tableView.dataSource = self
        
        RestAPI.getAllLocations(filter: nil) { (response, error) in
            self.data = response?.results ?? []
            self.tableView.numberOfCells = self.data.count
            self.tableView.reloadData()
            self.filter = RMLocationFilter(url: response?.info.next ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableView.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.getCorrectCell(indexPath: indexPath, dataCount: self.data.count) { () -> UITableViewCell in
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCell
            let location = self.data[indexPath.row]
            
            cell.nameLabel.text = location.name
            cell.typeLabel.text = location.type
            cell.dimensionLabel.text = location.dimension
            
            cell.onSelection = {
                let charactersIDs = RestAPI.getIDs(urls: location.residents, urlBase: RestAPI.charactersBaseURL)
                
                if charactersIDs.isEmpty {
                    self.showCharactersAlert(characters: [], title: location.name)
                    return
                }
                
                RestAPI.getMultipleCharacters(ids: charactersIDs) { (characters, error) in
                    self.showCharactersAlert(characters: characters ?? [], title: location.name)
                }
            }
            
            return cell
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView.willDisplayCell(indexPath: indexPath, dataCount: self.data.count) {
            RestAPI.getAllLocations(filter: self.filter) { (response, error) in
                self.data.append(contentsOf: response?.results ?? [])
                self.filter = RMLocationFilter(url: response?.info.next ?? "")
                if response?.info.next == "" {
                    self.tableView.setNoMoreData()
                }
                self.tableView.afterAppendRequest(dataCount: self.data.count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

}
