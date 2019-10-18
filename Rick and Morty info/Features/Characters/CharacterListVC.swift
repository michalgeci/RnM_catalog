//
//  CharacterListVC.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

class CharacterListVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarDelimiterHeightConstraint: NSLayoutConstraint!
    
    var characters: [RMCharacter] = []
    
    var numberOfCells: Int = 0
    var addedLoader = false
    var filter: RMCharacterFilter = RMCharacterFilter(page: nil, name: "", status: nil, species: nil, type: nil, gender: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.searchBar.delegate = self
        self.searchBarDelimiterHeightConstraint.constant = 0.5
        
        self.initRequest()
    }
    
    func initRequest() {
        RestAPI.getAllCharacters(filter: self.filter) { (response, error) in
            self.characters = response?.results ?? []
            self.numberOfCells = self.characters.count
            self.filter =  RMCharacterFilter(url: response?.info.next ?? "")
            self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.addedLoader = false
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Search bar methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.filter = RMCharacterFilter(page: nil, name: searchBar.text, status: nil, species: nil, type: nil, gender: nil)
        self.initRequest()
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: - Keyboard methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var contentInset: UIEdgeInsets = self.collectionView.contentInset
        contentInset.bottom = keyboardRect.size.height - (self.tabBarHeight ?? 0)
        self.collectionView.contentInset = contentInset
        self.collectionView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.collectionView.contentInset = contentInset
        self.collectionView.scrollIndicatorInsets = contentInset
    }
    
    @IBAction func tapAnywhere(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterDetailVC = segue.destination as? CharacterDetailVC {
            if let character = sender as? RMCharacter {
                characterDetailVC.character = character
            }
        }
    }
    
    
}
