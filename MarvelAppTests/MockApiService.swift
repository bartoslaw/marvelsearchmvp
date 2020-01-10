//
//  MockApiService.swift
//  MarvelAppTests
//
//  Created by Bartłomiej Smektała on 10/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class MockApiService: ApiService {
    func baseUrl() -> String {
        return "http://testapi.com"
    }
    
    func getComics(offset: Int) -> Single<[ComicBookModel]> {
        guard
            let comicBooks = self.getComicBooks()
        else {
            return Single.just([])
        }
        
        return Single.just(comicBooks)
    }
    
    func getComics(query: String, offset: Int) -> Single<[ComicBookModel]> {
        guard
            let comicBooks = self.getComicBooks()
        else {
            return Single.just([])
        }
        
        return Single.just(comicBooks.filter { $0.title!.contains(query) })
    }
    
    private func getComicBooks() -> [ComicBookModel]? {
        guard
            let json = self.readJson(),
            let result = Mapper<ApiResponseModel>().map(JSONObject: json),
            let comicBooks = result.data?.results
        else {
            return nil
        }
        
        return comicBooks
    }
    
    private func readJson() -> Any? {
        if let path = Bundle.main.path(forResource: "api_response", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                return jsonResult
              } catch {
                   return nil
              }
        }
        return nil
    }
}
