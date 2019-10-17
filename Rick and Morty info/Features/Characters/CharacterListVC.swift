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
    private var addedLoader = false
    private var nextPageUrl = ""
    private var filter: RMCharacterFilter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        RestAPI.getAllCharacters(filter: self.filter) { (response, error) in
            self.characters = response?.results ?? []
            self.numberOfCells = self.characters.count
            self.nextPageUrl = response?.info.next ?? ""
            
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCharacterDetail", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.characters.count && !addedLoader {
            print("SHOULD LOAD NEW")
            self.numberOfCells += 1
            self.addedLoader = true
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                RestAPI.getAllCharacters(pageURL: self.nextPageUrl, filter: self.filter) { (response, error) in
                    self.nextPageUrl = response?.info.next ?? ""
                    self.characters.append(contentsOf: response?.results ?? [])
                    self.numberOfCells = self.characters.count
                    self.addedLoader = false
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < self.characters.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCell
            cell.initDefaults()
            cell.assignCharacter(character: self.characters[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.startAnimation()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 24) / 2
        let height = width / 1.62
        
        if indexPath.row < self.characters.count {
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 16, height: 32)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
