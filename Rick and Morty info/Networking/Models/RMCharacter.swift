//
//  RMCharacter.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation

struct RMCharacter: Decodable {
    
    struct Origin: Decodable {
        var name: String
        var url: String
    }
    
    struct Location: Decodable {
        var name: String
        var url: String
    }
    
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }
    
    var id: Int
    var name: String
    var status: Status
    var species: String
    var type: String
    var gender: Gender
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}
