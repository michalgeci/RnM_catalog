//
//  EpisodesVC.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 20/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

class EpisodesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var separatorTopHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: CustomTableView!
    
    var data: [RMEpisode] = []
    var filter = RMEpisodeFilter(page: nil, name: nil, episode: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        separatorTopHeightConstraint.constant = 0.5
        
        tableView.delegate = self
        tableView.dataSource = self
        
        RestAPI.getAllEpisodes(filter: nil) { (response, error) in
            self.data = response?.results ?? []
            self.filter = RMEpisodeFilter(url: response?.info.next)
            self.tableView.numberOfCells = self.data.count
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.getCorrectCell(indexPath: indexPath, dataCount: self.data.count) { () -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
            let episode = self.data[indexPath.row]
            
            cell.textLabel?.text = episode.name
            cell.detailTextLabel?.text = episode.episode
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView.willDisplayCell(indexPath: indexPath, dataCount: self.data.count) {
            RestAPI.getAllEpisodes(filter: self.filter) { (response, error) in
                self.data.append(contentsOf: response?.results ?? [])
                self.filter = RMEpisodeFilter(url: response?.info.next)
                if response?.info.next == "" || response?.info.next == nil {
                    self.tableView.setNoMoreData()
                }
                self.tableView.afterAppendRequest(dataCount: self.data.count)
            }
        }
    }
    
    // Show alert with characters in selected episode
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.data[indexPath.row]
        let ids = RestAPI.getIDs(urls: episode.characters, urlBase: RestAPI.charactersBaseURL)
        
        RestAPI.getMultipleCharacters(ids: ids) { (characters, error) in
            let title = "\(episode.episode) - \(episode.name)\n\(episode.air_date)"
            self.showCharactersAlert(characters: characters ?? [], title: title)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

}
