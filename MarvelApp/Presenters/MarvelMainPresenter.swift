//
//  MarvelMainPresenter.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation

class MarvelMainPresenter: MainPresenter {
    var apiService: ApiService?
    var mainView: MainView?
    
    func getComics() {
        
    }
    
    func searchComics(query: String) {
        
    }
    
    func getItemsCount() -> Int {
        return 0
    }
    
    func getItemAtPosition(index: Int) -> ComicBookModel {
        return ComicBookModel(JSON: [:])!
    }
    
    
}
