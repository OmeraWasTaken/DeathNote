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
    var deathDto = PublishSubject<DeathDto>()
    private let deathRepository: DeathRepository

    init(deathRepository: DeathRepository) {
        self.deathRepository = deathRepository
    }

    func confirmKill() {
    }
}
