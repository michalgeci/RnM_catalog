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
    
    // MARK: - Characters
    
    private static var charactersBaseURL = "https://rickandmortyapi.com/api/character/"
    
    /** Obtain all characters */
    static func getAllCharacters(pageURL: String = RestAPI.charactersBaseURL,
                                 filter: RMCharacterFilter?,
                                 completion: @escaping ( _ response: CharactersResponse?, _ error: AFError?) -> Void ) {
        
        // Perform request
        AF.request(pageURL, method: .get, parameters: filter?.toRequestParameter()).responseDecodable(of: CharactersResponse.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
    }
    
    /** Get character detail */
    static func getCharacterDetail(id: Int, completion: @escaping ( _ response: RMCharacter?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.charactersBaseURL + String(id)
        
        // Perform request
        AF.request(requestURL, method: .get).responseDecodable(of: RMCharacter.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
    }
    
    // MARK: - Locations
    
    private static var locationsBaseURL = "https://rickandmortyapi.com/api/location/"
    
    /** Obtain all locations */
    static func getAllLocations(pageURL: String = RestAPI.locationsBaseURL,
                                completion: @escaping ( _ response: LocationsResponse?, _ error: AFError?) -> Void ) {
        
        // Perform request
        AF.request(pageURL, method: .get).responseDecodable(of: LocationsResponse.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
    }
    
    /** Get location detail */
    static func getLocationDetail(id: Int, completion: @escaping ( _ response: RMLocation?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.locationsBaseURL + String(id)
        
        // Perform request
        AF.request(requestURL, method: .get).responseDecodable(of: RMLocation.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
    }
    
    // MARK: - Episodes
    
    private static var episodesBaseURL = "https://rickandmortyapi.com/api/episode/"
    
    /** Obtain all episodes */
    static func getAllEpisodes(pageURL: String = RestAPI.episodesBaseURL,
                               completion: @escaping ( _ response: EpisodesResponse?, _ error: AFError?) -> Void ) {
        
        // Perform request
        AF.request(pageURL, method: .get).responseDecodable(of: EpisodesResponse.self) {
            response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, response.error )
            }
        }
    }
    
    /** Get episode detail */
    static func getEpisodeDetail(id: Int, completion: @escaping ( _ response: RMEpisode?, _ error: AFError?) -> Void) {
        
        let requestURL = RestAPI.episodesBaseURL + String(id)
        
        // Perform request
        AF.request(requestURL, method: .get).responseDecodable(of: RMEpisode.self) {
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
