//
//  AddDeathViewModel.swift
//  DeathNote
//
//  Created by Quentin Richard on 31/03/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import RxSwift

protocol AddDeathViewModel {
    func confirmKill(death: DeathDto)
}
