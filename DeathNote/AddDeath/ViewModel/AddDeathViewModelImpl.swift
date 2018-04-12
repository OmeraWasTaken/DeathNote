//
//  AddDeathViewModelImpl.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit
import RxSwift

class AddDeathViewModelImpl: AddDeathViewModel {
    private let deathRepository: DeathRepository

    init(deathRepository: DeathRepository) {
        self.deathRepository = deathRepository
    }

    func confirmKill(death: DeathDto) {
        let savingDeath = Death(deathId: death.deathId, firstName: death.firstName,
                                lastName: death.lastName, date: death.date,
                                reasonOfDeath: death.reasonOfDeath, picture: death.picture)
        deathRepository.saveDeath(death: savingDeath)
        deathRepository.createAnEvent(death: savingDeath)
    }

}
