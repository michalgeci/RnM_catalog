//
//  LoadingCell.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 17/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    func startAnimation() {
        indicator.startAnimating()
    }
    
    func stopAnimation() {
        indicator.stopAnimating()
    }
}
