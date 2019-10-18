//
//  CharacterListVC+CollectionView.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 18/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

extension CharacterListVC {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = self.characters[indexPath.row]
        self.performSegue(withIdentifier: "showCharacterDetail", sender: character)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.characters.count && !addedLoader {
            self.numberOfCells += 1
            self.addedLoader = true
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                if self.filter?.page != nil {
                    RestAPI.getAllCharacters(filter: self.filter) { (response, error) in
                        self.filter = RestAPI.parseCharacterFilter(url: response?.info.next ?? "")
                        self.characters.append(contentsOf: response?.results ?? [])
                        self.numberOfCells = self.characters.count
                        self.addedLoader = false
                        self.collectionView.reloadData()
                    }
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
            if self.filter?.page == nil {
                cell.label.text = "No more data"
                cell.stopAnimation()
            } else {
                cell.startAnimation()
            }
            return cell
        }
    }
    
    // MARK: - Layout methods
    
    // Set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 24) / 2
        let height = width / 1.62
        
        if indexPath.row < self.characters.count {
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 16, height: 32)
        }

    }
    
    // Set spacing
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
