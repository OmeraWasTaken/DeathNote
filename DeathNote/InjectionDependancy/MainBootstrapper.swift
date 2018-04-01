//
//  MainBootstrapper.swift
//  DeathNote
//
//  Created by Quentin Richard on 31/03/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import Swinject

public struct MainBootstrapper {
    public static let shared = MainBootstrapper()

    private let container: Container

    private init() {
        container = Container()
        registerContainer()
    }

    func registerContainer() {
    self.registerRepositories()
    self.registerViewModels()
    }

    private func registerRepositories() {
        self.container.register(DeathRepository.self) { _ in
            DeathRepositoryImpl()
        }
    }

    private func registerViewModels() {
        self.container.register(AddDeathViewModel.self) { _ in
            AddDeathViewModelImpl(deathRepository: self.container.resolve(DeathRepository.self)!)
        }
        self.container.register(ListOfDeathViewModel.self) { _ in
            ListOfDeathViewModelImpl(deathRepository: self.container.resolve(DeathRepository.self)!)
        }
        self.container.register(DeathDetailViewModel.self) { _ in
            DeathDetailViewModelImpl(deathRepository: self.container.resolve(DeathRepository.self)!)
        }
    }
}
