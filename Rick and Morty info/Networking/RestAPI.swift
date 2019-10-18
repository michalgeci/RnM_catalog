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
        
        // Perform request
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    // MARK: Parse character filter
    /** Parse character filter */
    static func parseCharacterFilter(url: String) -> RMCharacterFilter {
        let filter = RMCharacterFilter(page: nil, name: nil, status: nil, species: nil, type: nil, gender: nil)
        let params = URL(string: url)?.params()
        
        if let page = params?["page"] as? String {
            let pageInt = Int(page)
            filter.page = pageInt
        }
        
        if let name = params?["name"] as? String {
            filter.name = name
        }
        
        if let status = params?["status"] as? String {
            filter.status = RMCharacter.Status.init(rawValue: status)
        }
        
        if let species = params?["species"] as? String {
            filter.species = species
        }
        
        if let type = params?["type"] as? String {
            filter.type = type
        }
        
        if let gender = params?["gender"] as? String {
            filter.gender = RMCharacter.Gender.init(rawValue: gender)
        }
        
        return filter
    }
    
    // MARK: - Locations
    
    static let locationsBaseURL = "https://rickandmortyapi.com/api/location/"
    
    /** Obtain all locations */
    static func getAllLocations(pageURL: String = RestAPI.locationsBaseURL,
                                completion: @escaping ( _ response: LocationsResponse?, _ error: AFError?) -> Void ) {
        // Perform request
        universalRequest(url: pageURL, params: nil, completion: completion)
    }
    
    /** Get location detail */
    static func getLocationDetail(id: Int, completion: @escaping ( _ response: RMLocation?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.locationsBaseURL + String(id)
        
        // Perform request
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    // MARK: - Episodes
    
    static let episodesBaseURL = "https://rickandmortyapi.com/api/episode/"
    
    /** Obtain all episodes */
    static func getAllEpisodes(pageURL: String = RestAPI.episodesBaseURL,
                               completion: @escaping ( _ response: EpisodesResponse?, _ error: AFError?) -> Void ) {
        
        // Perform request
        universalRequest(url: pageURL, params: nil, completion: completion)
    }
    
    /** Get episode detail */
    static func getEpisodeDetail(id: Int, completion: @escaping ( _ response: RMEpisode?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.episodesBaseURL + String(id)
        
        // Perform request
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
    
    /** Get multiple episodes details */
    static func getMultipleEpisodes(ids: [Int], completion: @escaping ( _ response: [RMEpisode]?, _ error: AFError?) -> Void) {
        
        var idsStr = ""
        for id in ids {
            idsStr += String(id) + ","
        }
        
        let requestURL = RestAPI.episodesBaseURL + idsStr
        
        // Perform request
        universalRequest(url: requestURL, params: nil, completion: completion)
    }
}
