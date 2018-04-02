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
        let deathData = deathRepository.getAllDeath()
        let allDeath = deathData.deathList
        var listOfDeath = [DeathDto]()
        for data in allDeath {
            let death = DeathDto(id: data.id, firstName: data.firstName, lastName: data.lastName, date: data.date, reasonOfDeath: data.reasonOfDeath, picture: data.picture)
            listOfDeath.append(death)
        }
        listOfDeathDto.onNext(listOfDeath)
    }
}
