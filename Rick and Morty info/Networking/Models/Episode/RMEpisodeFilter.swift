//
//  RMEpisodeFilter.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 20/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation
import Alamofire

class RMEpisodeFilter {
    
    var page: Int?
    var name: String?
    var episode: String?

    init(page: Int?, name: String?, episode: String?) {
        self.page = page
        self.name = name
        self.episode = episode
    }
    
    init(url: String) {
        let params = URL(string: url)?.params()
        
        if let page = params?["page"] as? String {
            let pageInt = Int(page)
            self.page = pageInt
        }
        
        if let name = params?["name"] as? String {
            self.name = name
        }
        
        if let episode = params?["episode"] as? String {
            self.episode = episode
        }
    }
    
    func toRequestParameter() -> Parameters {
        var params: [String: Any] = [:]
        
        if let page = self.page {
            params["page"] = page
        }
        
        if let name = self.name {
            params["name"] = name
        }
        
        if let episode = self.episode {
            params["episode"] = episode
        }
        
        return params
    }
}
