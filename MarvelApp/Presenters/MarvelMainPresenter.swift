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
    
    var comicBooks: [ComicBookModel] = []
    
    func getComics() {
        
    }
    
    func searchComics(query: String) {
        
    }
    
    func getItemsCount() -> Int {
        return self.comicBooks.count
    }
    
    func getItemAtPosition(index: Int) -> ComicBookModel? {
        if self.comicBooks.count <= index {
            return nil
        }
        
        return self.comicBooks[index]
    }
    
    
}
