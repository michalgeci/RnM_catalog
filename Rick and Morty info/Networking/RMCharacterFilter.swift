//
//  RMCharacterFilter.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation
import Alamofire

class RMCharacterFilter {
     
    var page: Int?
    var name: String?
    var status: RMCharacter.Status?
    var species: String?
    var type: String?
    var gender: RMCharacter.Gender?
    
    init(page: Int?, name: String?, status: RMCharacter.Status?, species: String?, type: String?, gender: RMCharacter.Gender?) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
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
        
        if let status = params?["status"] as? String {
            self.status = RMCharacter.Status.init(rawValue: status)
        }
        
        if let species = params?["species"] as? String {
            self.species = species
        }
        
        if let type = params?["type"] as? String {
            self.type = type
        }
        
        if let gender = params?["gender"] as? String {
            self.gender = RMCharacter.Gender.init(rawValue: gender)
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
        
        if let status = self.status {
            params["status"] = status.rawValue
        }
        
        if let species = self.species {
            params["species"] = species
        }
        
        if let type = self.type {
            params["type"] = type
        }
        
        if let gender = self.gender {
            params["gender"] = gender.rawValue
        }
        
        return params
    }
}
