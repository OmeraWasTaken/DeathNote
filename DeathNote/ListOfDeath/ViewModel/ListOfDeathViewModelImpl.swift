//
//  ListOfDeathViewModelImpl.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import RxSwift

class ListOfDeathViewModelImpl: ListOfDeathViewModel {
    var listOfDeathDto = PublishSubject<[DeathDto]>()
    var deathRepository: DeathRepository

    init(deathRepository: DeathRepository){
        self.deathRepository = deathRepository
    }

    func getListOfDeath() {
    }
}
