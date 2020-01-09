//
//  ApiService.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiService: class {    
    func getComics() -> Single<[ComicBookModel]>
    func getComics(query: String) -> Single<[ComicBookModel]>
    func baseUrl() -> String
}
