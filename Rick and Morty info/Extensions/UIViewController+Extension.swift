//
//  UIViewController+Extension.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 18/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

extension UIViewController {

    /** Height of bottom tab bar */
    var tabBarHeight: CGFloat? {
        return self.tabBarController?.tabBar.frame.size.height
    }
    
    /** Show alert with characters */
    func showCharactersAlert(characters: [RMCharacter], title: String) {
        var message = "Characters:\n\n"
        for character in characters {
            message += character.name + "\n"
        }
        
        if characters.isEmpty {
            message += "🤷‍♂️ Empty? 🤷‍♀️"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
