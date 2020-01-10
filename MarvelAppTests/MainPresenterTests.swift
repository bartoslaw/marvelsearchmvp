//
//  MainPresenterTests.swift
//  MarvelAppTests
//
//  Created by Bartłomiej Smektała on 10/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import XCTest
import RxSwift

class MainPresenterTests: XCTestCase {
    var mainPresenter: MarvelMainPresenter?
    
    override func setUp() {
        self.mainPresenter = MarvelMainPresenter()
        
        self.mainPresenter?.apiService = MockApiService()
        self.mainPresenter?.disposeBag = DisposeBag()
    }

    override func tearDown() {
    }

    func testOffsetIncrement() {
        guard let mainPresenter = self.mainPresenter else {
            XCTFail()
            return
        }
        
        mainPresenter.getComics()
        XCTAssert(mainPresenter.offset > 0)
    }
    
    func testGetItemCount() {
        guard let mainPresenter = self.mainPresenter else {
            XCTFail()
            return
        }
        
        mainPresenter.getComics()
        XCTAssert(mainPresenter.getItemsCount() > 0)
    }
    
    func testGetItemAtPosition() {
        guard let mainPresenter = self.mainPresenter else {
            XCTFail()
            return
        }
        
        mainPresenter.getComics()
        XCTAssert(mainPresenter.getItemAtPosition(index: 0) != nil)
    }

}
