//
//  ListOfDeathCell.swift
//  DeathNote
//
//  Created by Quentin Richard on 30/03/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit

class ListOfDeathCell: UITableViewCell {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    var idCell = String()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
