//
//  UITableViewCell+Extensions.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
