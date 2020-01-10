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
    var mainView: MockView?
    
    override func setUp() {
        self.mainPresenter = MarvelMainPresenter()
        
        self.mainPresenter?.apiService = MockApiService()
        self.mainPresenter?.disposeBag = DisposeBag()
        self.mainView = MockView()
        
        self.mainPresenter?.mainView = mainView
    }

    override func tearDown() {
    }

    func testOffsetIncrement() {
        let mainPresenter = self.getPresenter()
        
        mainPresenter.getComics()
        XCTAssert(mainPresenter.offset > 0)
    }
    
    func testGetItemCount() {
        let mainPresenter = self.getPresenter()
        
        mainPresenter.getComics()
        XCTAssert(mainPresenter.getItemsCount() > 0)
    }
    
    func testGetItemAtPosition() {
        let mainPresenter = self.getPresenter()
        
        mainPresenter.getComics()
        XCTAssert(mainPresenter.getItemAtPosition(index: 0) != nil)
    }
    
    func testUpdateTableViewHasBeenCalled() {
        let mainPresenter = self.getPresenter()
        let mainView = self.getView()
        
        mainPresenter.getComics()
        XCTAssert(mainView.updateTableViewHasBeenCalled)
    }
    
    func testEmptyResultsHasBeenCalled() {
        let mainPresenter = self.getPresenter()
        let mainView = self.getView()
        
        mainPresenter.searchComics(query: "@#!@$@4")
        XCTAssert(mainView.emptyResultsHasBeenCalled)
    }
    
    func testErrorHasBeenCalled() {
        let mainPresenter = self.getPresenter()
        let mainView = self.getView()
        
        mainPresenter.offset = -1
        mainPresenter.getComics()
        XCTAssert(mainView.displayErrorHasBeenCalled)
    }
    
    func testShowLoaderHasBeenCalled() {
        let mainPresenter = self.getPresenter()
        let mainView = self.getView()
        
        mainPresenter.getComics()
        XCTAssert(mainView.showLoaderHasBeenCalled)
    }
    
    func testHideLoaderHasBeenCalled() {
        let mainPresenter = self.getPresenter()
        let mainView = self.getView()
        
        mainPresenter.getComics()
        XCTAssert(mainView.showLoaderHasBeenCalled)
    }
    
    private func getPresenter() -> MainPresenter {
        guard let mainPresenter = self.mainPresenter else { return MarvelMainPresenter() }
        return mainPresenter
    }
    
    private func getView() -> MockView {
        guard let mainView = self.mainView else { return MockView() }
        return mainView
    }
}

class MockView: MainView {
    var updateTableViewHasBeenCalled: Bool = false
    var emptyResultsHasBeenCalled: Bool = false
    var displayErrorHasBeenCalled: Bool = false
    var showLoaderHasBeenCalled: Bool = false
    var hideLoaderHasBeenCalled: Bool = false
    
    func updateTableView() {
        self.updateTableViewHasBeenCalled = true
    }
    
    func displayError() {
        self.displayErrorHasBeenCalled = true
    }
    
    func emptyResults() {
        self.emptyResultsHasBeenCalled = true
    }
    
    func showLoader() {
        self.showLoaderHasBeenCalled = true
    }
    
    func hideLoader() {
        self.hideLoaderHasBeenCalled = true
    }
}
