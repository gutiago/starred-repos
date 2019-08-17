//
//  ObservableType.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit

extension UIFont {
    enum Quicksand : String {
        case medium = "Quicksand-Medium"
        case regular = "Quicksand-Regular"
        case light = "Quicksand-Light"
        
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
}
