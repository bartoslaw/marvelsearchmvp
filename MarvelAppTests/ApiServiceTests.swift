//
//  ApiServiceTests.swift
//  MarvelAppTests
//
//  Created by Bartłomiej Smektała on 10/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import XCTest
import RxSwift

class ApiServiceTests: XCTestCase {
    var apiService: ApiService?
    var disposeBag: DisposeBag?
    
    override func setUp() {
        self.apiService = MockApiService()
        self.disposeBag = DisposeBag()
    }

    override func tearDown() {}

    func testGetComicBooks() {
        self.apiService?
            .getComics(offset: 0)
            .subscribe(onSuccess: { models in
                XCTAssert(!models.isEmpty)
            }, onError: { _ in })
            .disposed(by: self.disposeBag!)
    }
    
    func testSearchRequest() {
        self.apiService?
            .getComics(query: "Hulk", offset: 0)
            .subscribe(onSuccess: { models in
                XCTAssert(!models.isEmpty)
            }, onError: { _ in
                
            })
            .disposed(by: self.disposeBag!)
    }
    
    func testSearchEmptyResult() {
        self.apiService?
            .getComics(query: "@!#@!##@#", offset: 0)
            .subscribe(onSuccess: { models in
                XCTAssert(models.isEmpty)
            }, onError: { _ in
            
            })
            .disposed(by: self.disposeBag!)
    }
}
