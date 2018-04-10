//
//  DeathDetailViewModel.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import RxSwift

protocol DeathDetailViewModel {
    var deathDto: PublishSubject<DeathDto> {get}
    func getDeathDetail(id: String)
}
