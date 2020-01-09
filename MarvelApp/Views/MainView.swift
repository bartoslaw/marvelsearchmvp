//
//  MainView.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation

protocol MainView: class {
    func updateTableView()
    func displayError()
    func emptyResults()
}
