//
//  CharacterDetailVC.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 18/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var character: RMCharacter!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var foregroundImage: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    private let placeholderImage = UIImage(named: "ic_face_32")
    var properties: [String] = []
    var details: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view
        initTableViewData()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        // Set title
        navItem.title = character.name
        
        // Set background image
        let url = URL(string: character.image)
        self.backgroundImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        
        // Set foreground image
        self.foregroundImage.sd_setImage(with: url, placeholderImage: placeholderImage) { (_, _, _, _) in
            self.foregroundImage.contentMode = .scaleAspectFit
        }
    }
    
    /** Dismiss controller when clicked on "X" */
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = properties[indexPath.row]
        cell.detailTextLabel?.text = details[indexPath.row]
        return cell
    }
    
    func initTableViewData() {
        self.properties = ["Status", "Species", "Gender", "Type", "Origin", "Location"]
        self.details = [character.status.rawValue, character.species, character.gender.rawValue, character.type, character.origin.name, character.location.name]
        
        if character.type == "" {
            self.details = [character.status.rawValue, character.species, character.gender.rawValue, character.origin.name, character.location.name]
            self.properties = ["Status", "Species", "Gender", "Origin", "Location"]
        }
    }

}
