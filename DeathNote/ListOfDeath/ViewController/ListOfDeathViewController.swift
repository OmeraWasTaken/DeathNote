//
//  ListOfDeathViewControlelr.swift
//  DeathNote
//
//  Created by Quentin Richard on 30/03/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListOfDeathViewController: UITableViewController {
    @IBOutlet weak var tableViewListOfDeath: UITableView!
    let viewModel: ListOfDeathViewModel = MainBootstrapper.resolve(interface: ListOfDeathViewModel.self)
    private let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.dataSource = nil
        tableView.register(UINib(nibName: "ListOfDeathCell", bundle: nil), forCellReuseIdentifier: "deathCell")
        viewModel
            .listOfDeathDto
            .asObservable()
            .bind(to: tableViewListOfDeath
                .rx
                .items(cellIdentifier: "deathCell",
                       cellType: ListOfDeathCell.self)) { _, data, cell in
                        cell.firstName.text = data.firstName
                        cell.lastName.text = data.lastName
                        cell.profilePicture.image = data.picture
                        cell.idCell = data.deathId
            }.disposed(by: disposeBag)
        viewModel.getListOfDeath()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? ListOfDeathCell
        guard let deathId = selectedCell?.idCell else {
            return
        }
        MainBootstrapper.shared.deathId = deathId
        self.performSegue(withIdentifier: "toDeathDetail", sender: nil)
    }
}
