//
//  CharacterCell.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 16/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foregroundImage: UIImageView!
    
    private let placeholderImage = UIImage(named: "ic_face_32")
    
    func assignCharacter(character: RMCharacter) {
        // Set name of character
        self.nameLabel.text = character.name
        
        // Set images from URL
        let url = URL(string: character.image)
        self.backgroundImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        self.foregroundImage.sd_setImage(with: url, placeholderImage: placeholderImage) { (_, _, _, _) in
            self.foregroundImage.contentMode = .scaleAspectFill
        }
    }
    
    func initDefaults() {
        // Calculate real size of cell
        self.layoutIfNeeded()
        
        // Select Blur style for present UI style
        if traitCollection.userInterfaceStyle == .dark {
            blur.effect = UIBlurEffect(style: .dark)
        } else {
            blur.effect = UIBlurEffect(style: .extraLight)
        }
        
        // Reset name
        self.nameLabel.text = "_-_-_-_"
        
        // Reset placeholder images
        self.foregroundImage.contentMode = .center
        self.foregroundImage.image = placeholderImage
        self.backgroundImage.image = placeholderImage
    }
    
    override func draw(_ rect: CGRect) {
        // Set corner radius for cell
        self.layer.cornerRadius = 8
        
        // Allow shadow drawing out of view
        self.foregroundImage.layer.masksToBounds = true
        
        // Set corner radius of image
        let cornerRadius = self.foregroundImage.frame.height/2
        self.foregroundImage.layer.cornerRadius = cornerRadius
        self.foregroundImage.layer.borderColor = UIColor.white.cgColor
        self.foregroundImage.layer.borderWidth = 2
    }
    
}
