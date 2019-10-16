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
     
    var name: String?
    var status: RMCharacter.Status?
    var species: String?
    var type: String?
    var gender: RMCharacter.Gender?
    
    init(name: String?, status: RMCharacter.Status?, species: String?, type: String?, gender: RMCharacter.Gender?) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
    }
    
    func toRequestParameter() -> Parameters {
        var params: [String: Any] = [:]
        
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
