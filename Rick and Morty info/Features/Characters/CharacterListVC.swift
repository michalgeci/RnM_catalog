//
//  CharacterListVC.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

class CharacterListVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters: [RMCharacter] = []
    
    var numberOfCells: Int = 0
    var addedLoader = false
    var filter: RMCharacterFilter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.filter = RMCharacterFilter(page: nil, name: "Rick", status: nil, species: nil, type: nil, gender: nil)
        
        RestAPI.getAllCharacters(filter: self.filter) { (response, error) in
            self.characters = response?.results ?? []
            self.numberOfCells = self.characters.count
            self.filter = RestAPI.parseCharacterFilter(url: response?.info.next ?? "")
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterDetailVC = segue.destination as? CharacterDetailVC {
            if let character = sender as? RMCharacter {
                characterDetailVC.character = character
            }
        }
    }
    
    
}
