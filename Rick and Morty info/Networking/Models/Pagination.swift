//
//  Pagination.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation

struct Pagination: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
