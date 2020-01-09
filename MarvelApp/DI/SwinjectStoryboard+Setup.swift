//
//  SwinjectStoryboard+Setup.swift
//  MarvelApp
//
//  Created by Bartłomiej Smektała on 09/01/2020.
//  Copyright © 2020 Bartłomiej Smektała. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.register(ApiService.self) { _ in
            MarvelApiService()
        }.inObjectScope(.container)
        
        defaultContainer.register(MainPresenter.self) { resolver in
            let presenter = MarvelMainPresenter()
            presenter.apiService = resolver.resolve(ApiService.self)
            
            return presenter
        }.inObjectScope(.container)
        
        // MARK: - View controllers
        defaultContainer.storyboardInitCompleted(MainViewController.self) { (resolver, controller) in
            controller.mainPresenter = resolver.resolve(MainPresenter.self)
        }
    }
}
