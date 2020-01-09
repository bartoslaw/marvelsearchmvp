//
//  MarvelMainPresenter.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import RxSwift

class MarvelMainPresenter: MainPresenter {
    var disposeBag: DisposeBag?
    var apiService: ApiService?
    var mainView: MainView?
    
    var offset = 0
    var isLoading = false
    
    var comicBooks: [ComicBookModel] = []
    
    func getComics() {
        guard let disposeBag = self.disposeBag else { return }
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        
        self.apiService?
            .getComics(offset: self.offset)
            .subscribe(onSuccess: { [weak self] models in
                guard let context = self else { return }
                
                context.comicBooks.append(contentsOf: models)
                context.mainView?.updateTableView()
                context.isLoading = false
                context.offset += 1
                
                if context.comicBooks.isEmpty {
                    context.mainView?.emptyResults()
                }
            }, onError: { [weak self] _ in
                guard let context = self else { return }
                    
                context.mainView?.displayError()
                context.isLoading = false
            })
            .disposed(by: disposeBag)
    }
    
    func searchComics(query: String) {
        guard let disposeBag = self.disposeBag else { return }
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        self.apiService?
            .getComics(query: query, offset: self.offset)
            .subscribe(onSuccess: { [weak self] models in
                guard let context = self else { return }
                
                context.comicBooks.append(contentsOf: models)
                context.mainView?.updateTableView()
                context.isLoading = false
                context.offset += 1
                
                if context.comicBooks.isEmpty {
                    context.mainView?.emptyResults()
                }
            }, onError: { [weak self] _ in
                guard let context = self else { return }
                    
                context.mainView?.displayError()
                context.isLoading = false
            })
            .disposed(by: disposeBag)
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
