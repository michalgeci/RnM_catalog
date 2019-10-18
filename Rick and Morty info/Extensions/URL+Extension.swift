//
//  URL+Extension.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 18/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation

extension URL {
  func params() -> [String:Any] {
    var dict = [String:Any]()

    if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
      if let queryItems = components.queryItems {
        for item in queryItems {
          dict[item.name] = item.value!
        }
      }
      return dict
    } else {
      return [:]
    }
  }
}
