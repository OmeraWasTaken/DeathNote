//
//  DeathRepository.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import Foundation

protocol DeathRepository {
    func getAllDeath() -> DeathList
    func saveDeath(death: Death)
}
