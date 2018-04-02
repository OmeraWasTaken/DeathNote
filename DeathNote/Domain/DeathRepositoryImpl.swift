//
//  DeathRepositoryImpl.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit
import RealmSwift
import EventKit

class DeathRepositoryImpl: DeathRepository {
    var id = String()
    let realm = try! Realm()

    func getSelectedDeath(id: String) -> Death {
        let data = realm.object(ofType: DeathData.self, forPrimaryKey: id) ?? DeathData()
        let image = UIImage(data: data.image) ?? UIImage()
        let death = Death(id: data.id, firstName: data.firstName, lastName: data.lastName, date: data.date, reasonOfDeath: data.reasonOfDeath, picture: image)
        return death
    }

    func getAllDeath() -> DeathList {
        let deathList = realm.objects(DeathData.self)
        var deaths = [Death]()
        for data in deathList {
            guard let image = UIImage(data: data.image) else {
                return DeathList(deathList: deaths)
            }
            let death = Death(id: data.id, firstName: data.firstName, lastName: data.lastName, date: data.date, reasonOfDeath: data.reasonOfDeath, picture: image)
            deaths.append(death)
        }
        return DeathList(deathList: deaths)
    }

    func saveDeath(death: Death) {
        try! self.realm.write {
            let deathData = DeathData()
            deathData.id = death.id
            deathData.firstName = death.firstName
            deathData.lastName = death.lastName
            deathData.date = death.date
            deathData.reasonOfDeath = death.reasonOfDeath
            guard let dataImage = (UIImageJPEGRepresentation(death.picture, 1.0)) else {
                return
            }
            deathData.image = dataImage
            realm.add(deathData)
        }
    }

    func createAnEvent(death: Death) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy-HH-mm"
        let eventStore : EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil) {
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "\(death.lastName) \(death.firstName) is dead"
                event.startDate = dateFormatter.date(from: death.date)
                event.endDate = dateFormatter.date(from: death.date)
                event.notes = death.reasonOfDeath
                let alarm = EKAlarm(relativeOffset: 0)
                event.addAlarm(alarm)
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
            }
            else{
                print("failed to save event with error : \(error) or access not granted")
            }
        }
    }
}
