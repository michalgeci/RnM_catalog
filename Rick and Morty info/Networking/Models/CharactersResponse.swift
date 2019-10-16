//
//  CharactersResponse.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation

struct CharactersResponse: Decodable {
    var info: Pagination
    var results: [RMCharacter]
}
