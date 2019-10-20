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
    
    // MARK: - Common request
    /** Universal GET request */
    static func universalRequest<T: Decodable>(url: String, params: Parameters?, completion: @escaping (T?, AFError?) -> Void) {
        
        AF.request(url, method: .get, parameters: params).responseDecodable(of: T.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
    }
    
    /** Convert array of Int-s to String where numbers are separated by comma */
    private static func getIDsString(_ from: [Int]) -> String {
        return from.reduce("") { $0 + "," + String($1) }
    }
    
    /** Get IDs from URL list */
    static func getIDs(urls: [String], urlBase: String) -> [Int] {
        var ids: [Int] = []
        for url in urls {
            guard let id = Int(url.replacingOccurrences(of: urlBase, with: "")) else { return [] }
            ids.append(id)
        }
        return ids
    }
    
    // MARK: - Characters
    
    static let charactersBaseURL = "https://rickandmortyapi.com/api/character/"
    
    /** Obtain all characters */
    static func getAllCharacters(filter: RMCharacterFilter?,
                                 completion: @escaping ( _ response: CharactersResponse?, _ error: AFError?) -> Void ) {
        // Perform request
        universalRequest(url: charactersBaseURL, params: filter?.toRequestParameter(), completion: completion)
    }
    
    /** Get character detail */
    static func getCharacterDetail(id: Int, completion: @escaping ( _ response: RMCharacter?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.charactersBaseURL + String(id)
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    /** Get multiple characters */
    static func getMultipleCharacters(ids: [Int], completion: @escaping ( _ response: [RMCharacter]?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.charactersBaseURL + getIDsString(ids)
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    // MARK: - Locations
    
    static let locationsBaseURL = "https://rickandmortyapi.com/api/location/"
    
    /** Obtain all locations */
    static func getAllLocations(filter: RMLocationFilter?,
                                completion: @escaping ( _ response: LocationsResponse?, _ error: AFError?) -> Void ) {

        universalRequest(url: locationsBaseURL, params: filter?.toRequestParameter(), completion: completion)
    }
    
    /** Get location detail */
    static func getLocationDetail(id: Int, completion: @escaping ( _ response: RMLocation?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.locationsBaseURL + String(id)
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    // MARK: - Episodes
    
    static let episodesBaseURL = "https://rickandmortyapi.com/api/episode/"
    
    /** Obtain all episodes */
    static func getAllEpisodes(filter: RMEpisodeFilter?,
                               completion: @escaping ( _ response: EpisodesResponse?, _ error: AFError?) -> Void ) {
        
        universalRequest(url: episodesBaseURL, params: filter?.toRequestParameter(), completion: completion)
    }
    
    /** Get episode detail */
    static func getEpisodeDetail(id: Int, completion: @escaping ( _ response: RMEpisode?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.episodesBaseURL + String(id)
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    /** Get multiple episodes details */
    static func getMultipleEpisodes(ids: [Int], completion: @escaping ( _ response: [RMEpisode]?, _ error: AFError?) -> Void) {
    
        let requestURL = RestAPI.episodesBaseURL + getIDsString(ids)
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
}
