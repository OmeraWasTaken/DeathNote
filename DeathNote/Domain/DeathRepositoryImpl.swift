//
//  DeathRepositoryImpl.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit

class DeathRepositoryImpl: DeathRepository {
    func getAllDeath() -> DeathList {
        let image = UIImage()
        let death = Death(id: "", firstName: "", lastName: "", date: "", reasonOfDeath: "", picture: image)
        return DeathList(deathList: [death])
    }

    func saveDeath(death: Death) {
    }

}
