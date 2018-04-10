//
//  KeyboardExtension.swift
//  DeathNote
//
//  Created by Quentin Richard on 02/04/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
