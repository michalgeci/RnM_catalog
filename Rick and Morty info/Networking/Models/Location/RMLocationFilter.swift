//
//  RMLocationFilter.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 20/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation
import Alamofire

class RMLocationFilter {
    
    var page: Int?
    var name: String?
    var type: String?
    var dimension: String?

    init(page: Int?, name: String?, type: String?, dimension: String?) {
        self.page = page
        self.name = name
        self.type = type
        self.dimension = dimension
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
        
        if let type = params?["type"] as? String {
            self.type = type
        }
        
        if let dimension = params?["dimension"] as? String {
            self.dimension = dimension
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
        
        if let type = self.type {
            params["type"] = type
        }
        
        if let dimension = self.dimension {
            params["dimension"] = dimension
        }
        
        return params
    }
}
