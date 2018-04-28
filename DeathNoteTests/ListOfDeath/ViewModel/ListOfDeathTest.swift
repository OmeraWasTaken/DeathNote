//
//  DeathNoteTests.swift
//  DeathNoteTests
//
//  Created by Quentin Richard on 28/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import XCTest
import RxSwift
@testable import DeathNote

class ListOfDeathTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testListOfDeathGetListOfDeath() {
        let disposeBag = DisposeBag()
        let deathRepository = TestListOfDeathDeathRepository()
        let sut = ListOfDeathViewModelImpl(deathRepository: deathRepository)
        let expectation = XCTestExpectation(description: "subscribe called")
        var result: DeathDto?
           _ = sut.listOfDeathDto.subscribe(onNext: { (data) in
            result = data[0]
            expectation.fulfill()
        }, onError: { _ in
        }, onCompleted: {}).disposed(by: disposeBag)
        sut.getListOfDeath()
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(result?.date, "12/02/2100")
        XCTAssertEqual(result?.deathId, "1")
        XCTAssertEqual(result?.firstName, "A")
        XCTAssertEqual(result?.lastName, "B")
        XCTAssertEqual(result?.reasonOfDeath, "C")
    }
}

class TestListOfDeathDeathRepository: DeathRepository {
    func getAllDeath() -> DeathList {
        let image = UIImage()
        let death = Death(deathId: "1", firstName: "A", lastName: "B",
                          date: "12/02/2100", reasonOfDeath: "C", picture: image)
        let deathList = DeathList(deathList: [death])
        return(deathList)
    }

    func saveDeath(death: Death) {
    }

    func getSelectedDeath(deathId: String) -> Death {
        let image = UIImage()
        return(Death(deathId: "1", firstName: "A", lastName: "B",
                     date: "12/02/2100", reasonOfDeath: "C", picture: image))
    }

    func createAnEvent(death: Death) {
    }
}
