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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foregroundImage: UIImageView!
    
    private var shadowLayer: CAShapeLayer!
    
    func assignCharacter(character: RMCharacter) {
        self.nameLabel.text = character.name
        let url = URL(string: character.image)
        let placeholderImage = UIImage(named: "ic_face_32")
        
        self.backgroundImage?.sd_setImage(with: url, placeholderImage: placeholderImage, options: SDWebImageOptions.init()) { (image, error, _, _) in
            if let image = image {
                self.foregroundImage.contentMode = .scaleAspectFill
                self.foregroundImage.image = image
            } else {
                self.foregroundImage.contentMode = .center
                self.foregroundImage.image = placeholderImage
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Calculate real size of cell
        self.layoutIfNeeded()
        
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
