//
//  MarvelApiService.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxCocoa
import ObjectMapper
import AlamofireObjectMapper

class MarvelApiService: ApiService {
    let limit = 25
    let apiKey = "3d3ce5daa8ec0f7c17afc52bb68f15f7"
    let hash = "a45bdb0bf57b06e72ad4c2c5854e2843"
    
    func baseUrl() -> String {
        return "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=\(self.apiKey)&hash=\(self.hash)&limit=\(self.limit)&orderBy=-onsaleDate"
    }
    
    func getComics(offset: Int) -> Single<[ComicBookModel]> {
        let endpoint = "\(self.baseUrl())&offset=\(offset * self.limit)"
        return self.makeRequest(endpoint: endpoint)
    }
    
    func getComics(query: String, offset: Int) -> Single<[ComicBookModel]> {
        let endpoint = "\(self.baseUrl())&offset=\(offset * self.limit)&title=\(query)"
        return self.makeRequest(endpoint: endpoint)
    }
    
    private func makeRequest(endpoint: String) -> Single<[ComicBookModel]> {
        return Single<[ComicBookModel]>.create(subscribe: { (observer) -> Disposable in
            let request = Alamofire.request(endpoint)
            request.responseJSON { (response) in
                if response.result.isFailure {
                    observer(.error(BackendError.parsingError))
                    return
                } else {
                    guard
                        let result = Mapper<ApiResponseModel>().map(JSONObject: response.result.value),
                        let comicBooks = result.data?.results
                        else {
                            observer(.error(BackendError.parsingError))
                            return
                    }
                    
                    observer(.success(comicBooks))
                }
            }
            
            return Disposables.create { request.cancel() }
        })
    }
}

enum BackendError: Error, Equatable {
    case noValue
    case parsingError
    case unauthorized
    case forbidden
    case badRequest
}
