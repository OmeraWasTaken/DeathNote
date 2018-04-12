//
//  DeathDetailViewController.swift
//  DeathNote
//
//  Created by Quentin Richard on 01/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit
import RxSwift

class DeathDetailViewController: UIViewController {
    @IBOutlet weak var profilPicture: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var reasonOfDeath: UITextView!
    let viewModel: DeathDetailViewModel = MainBootstrapper.resolve(interface: DeathDetailViewModel.self)
    let deathId = String()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {

        super.viewDidLoad()
          _ = viewModel.deathDto
                .asObservable()
                .subscribe(onNext: { (data) in
                    self.profilPicture.image = data.picture
                    self.firstName.text = data.firstName
                    self.lastName.text = data.lastName
                    self.date.text = data.date
                    self.reasonOfDeath.text = data.reasonOfDeath
                }, onCompleted: {})
                .disposed(by: disposeBag)
        viewModel.getDeathDetail(deathId: MainBootstrapper.shared.deathId)
    }
}
