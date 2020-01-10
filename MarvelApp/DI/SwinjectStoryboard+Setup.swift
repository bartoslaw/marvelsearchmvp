//
//  SwinjectStoryboard+Setup.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//
import Foundation
import Swinject
import SwinjectStoryboard
import RxSwift

extension SwinjectStoryboard {
    @objc class func setup() {        
        defaultContainer.register(DisposeBag.self) { _ in
            DisposeBag()
        }.inObjectScope(.container)
        
        defaultContainer.register(ApiService.self) { _ in
            MarvelApiService()
        }.inObjectScope(.container)
        
        defaultContainer.register(MainPresenter.self) { resolver in
            let presenter = MarvelMainPresenter()
            
            presenter.apiService = resolver.resolve(ApiService.self)
            presenter.disposeBag = resolver.resolve(DisposeBag.self)
            
            return presenter
        }.inObjectScope(.container)
        
        // MARK: - View controllers
        defaultContainer.storyboardInitCompleted(MainViewController.self) { (resolver, controller) in
            controller.mainPresenter = resolver.resolve(MainPresenter.self)
        }
    }
}
