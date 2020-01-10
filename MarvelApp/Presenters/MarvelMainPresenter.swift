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
    var lastQuery = ""
    
    var comicBooks: [ComicBookModel] = []
    
    func getComics() {
        guard let disposeBag = self.disposeBag else { return }
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        self.mainView?.showLoader()
        
        self.apiService?
            .getComics(offset: self.offset) 
            .subscribe(onSuccess: { [weak self] models in
                guard let context = self else { return }
                context.handleResponseSuccess(models: models)
            }, onError: { [weak self] _ in
                guard let context = self else { return }
                context.handleResponseFailure()
            })
            .disposed(by: disposeBag)
    }
    
    func searchComics(query: String) {
        guard let disposeBag = self.disposeBag else { return }
        
        if query.isEmpty && self.offset != 0 {
            self.offset = 0
            self.comicBooks.removeAll()
            self.getComics()
            return
        }
        
        if self.lastQuery != query {
            self.comicBooks.removeAll()
            self.offset = 0
        }
        
        self.lastQuery = query
        
        self.mainView?.showLoader()
        
        self.apiService?
            .getComics(query: query, offset: self.offset)
            .subscribe(onSuccess: { [weak self] models in
                guard let context = self else { return }
                context.handleResponseSuccess(models: models)
            }, onError: { [weak self] _ in
                guard let context = self else { return }
                context.handleResponseFailure()
            })
            .disposed(by: disposeBag)
    }
    
    private func handleResponseSuccess(models: [ComicBookModel]) {
        self.mainView?.hideLoader()
        self.comicBooks.append(contentsOf: models)
        self.offset += 1
        self.isLoading = false
        self.mainView?.updateTableView()
        
        if self.comicBooks.isEmpty {
            self.mainView?.emptyResults()
        }
    }
    
    private func handleResponseFailure() {
        self.mainView?.hideLoader()
        self.mainView?.displayError()
        self.isLoading = false
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
