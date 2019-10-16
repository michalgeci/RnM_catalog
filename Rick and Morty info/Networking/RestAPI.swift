//
//  RestAPI.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import Foundation
import Alamofire

final class RestAPI {
    
    static func getAllCharacters(pageURL: String = "https://rickandmortyapi.com/api/character/", completion: @escaping ( _ response: CharactersResponse?, _ error: AFError?) -> Void ) {
        
        AF.request(pageURL, method: .get).responseDecodable(of: CharactersResponse.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
        
    }
    
}
