//
//  UITableViewCellExtension.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
      return String(describing: self)
    }
}
