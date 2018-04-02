//
//  DeathData.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import RealmSwift

class DeathData: Object {
    @objc dynamic var id = String()
    @objc dynamic var firstName = String()
    @objc dynamic var lastName = String()
    @objc dynamic var date = String()
    @objc dynamic var reasonOfDeath = String()
    @objc dynamic var image = Data()

    override static func primaryKey() -> String? {
        return "id"
    }
}
