//
//  MarvelApiService.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import RxSwift

class MarvelApiService: ApiService {
    let limit = 25
    let apiKey = "3d3ce5daa8ec0f7c17afc52bb68f15f7"
    let hash = "a45bdb0bf57b06e72ad4c2c5854e2843"
    
    func baseUrl() -> String {
        return "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=\(self.apiKey)&hash=\(self.hash)&limit=\(self.limit)&orderBy=-onsaleDate"
    }

    func getComics(offset: Int) -> Single<[ComicBookModel]> {
        let endpoint = "\(self.baseUrl())&offset=\(offset * self.limit)"
        return Single.just([])
    }
    
    func getComics(query: String, offset: Int) -> Single<[ComicBookModel]> {
        let endpoint = "\(self.baseUrl())&offset=\(offset * self.limit)&query=\(query)"
        return Single.just([])
    }
    
}
