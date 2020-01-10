//
//  ListPresenter.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import RxSwift

protocol MainPresenter: class {
    var disposeBag: DisposeBag? { get set }
    var mainView: MainView? { get set }
    var apiService: ApiService? { get set }
    
    var offset: Int { get set }
    var isLoading: Bool { get set }
    var lastQuery: String { get set }
    
    func getComics()
    func searchComics(query: String)
    func getItemsCount() -> Int
    func getItemAtPosition(index: Int) -> ComicBookModel?
}
