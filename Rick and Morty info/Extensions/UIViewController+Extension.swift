//
//  UIViewController+Extension.swift
//  Rick and Morty info
//
//  Created by Michal Geci on 18/10/2019.
//  Copyright © 2019 MG. All rights reserved.
//

import UIKit

extension UIViewController {

    var tabBarHeight: CGFloat? {
        return self.tabBarController?.tabBar.frame.size.height
    }
}
