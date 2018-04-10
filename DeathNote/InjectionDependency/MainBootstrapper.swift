//
//  MainBootstrapper.swift
//  DeathNote
//
//  Created by Quentin Richard on 31/03/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import Swinject

public struct MainBootstrapper {
    public static var shared = MainBootstrapper()
    public var id = String()
    private let container: Container

    private init() {
        container = Container()
        registerContainer()
    }

    func registerContainer() {
    registerRepositories()
    registerViewModels()
    }

    private func registerRepositories() {
        container.register(DeathRepository.self) { _ in
            DeathRepositoryImpl()
        }
    }

    private func registerViewModels() {
        container.register(AddDeathViewModel.self) { _ in
            AddDeathViewModelImpl(deathRepository: self.container.resolve(DeathRepository.self)!)
        }
        container.register(ListOfDeathViewModel.self) { _ in
            ListOfDeathViewModelImpl(deathRepository: self.container.resolve(DeathRepository.self)!)
        }
        container.register(DeathDetailViewModel.self) { _ in
            DeathDetailViewModelImpl(deathRepository: self.container.resolve(DeathRepository.self)!)
        }
    }

    public func bind<T>(interface: T.Type, to assembly: T) {
        container.register(interface) { _ in assembly }
    }
    public func resolve<T>(interface: T.Type) -> T! {
        return container.resolve(interface)
    }

}

public extension MainBootstrapper {
    static func bind<T>(interface: T.Type, to assembly: T) {
        MainBootstrapper.shared.bind(interface: interface, to: assembly)
    }
    static func resolve<T>(interface: T.Type) -> T! {
        return MainBootstrapper.shared.resolve(interface: interface)
    }
}
