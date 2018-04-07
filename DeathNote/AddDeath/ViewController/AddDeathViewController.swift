//
//  AddDeathViewController.swift
//  DeathNote
//
//  Created by Quentin Richard on 31/03/2018.
//  Copyright © 2018 Quentin Richard. All rights reserved.
//

import UIKit
import Photos

class AddDeathViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var deathDateLabel: UITextField!
    @IBOutlet weak var reasonLabel: UITextView!
    let viewModel: AddDeathViewModel = MainBootstrapper.resolve(interface: AddDeathViewModel.self)

    override func viewDidLoad() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap(tapGestureRecognizer:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(gesture)
        hideKeyboardWhenTappedAround()
    }

    @objc func didTap(tapGestureRecognizer: UITapGestureRecognizer) {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization( {status in
                if (status == .authorized) {
                    self.photoLibraryPicker()
                }
            })
        }
        else if photos == .authorized {
            photoLibraryPicker()
        }
    }

    func photoLibraryPicker() {
        let alert = UIAlertController(title: "Select your way", message: NSLocalizedString("I need a face so please select a way of giving me the face", comment: ""),
                                      preferredStyle: .alert)
        alert.show(self, sender: self)
        let libraryAction = UIAlertAction(title: NSLocalizedString("Library", comment: ""), style: UIAlertActionStyle.default) { UIAlertAction in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: UIAlertActionStyle.default) { UIAlertAction in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            self.errorAlert(errorMessage: "Sadly there is no camera on this device :'(")
        }
        alert.addAction(libraryAction)
        alert.addAction(cameraAction)
        self.present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicture.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func confrirmKill() {
        let id = UUID().uuidString
        if (firstNameLabel.text == "" && lastNameLabel.text == "") {
            errorAlert(errorMessage: "I need the first name and the last name of the target to kill someone")
            return
        }
        if (deathDateLabel.text == "") {
            let date = Date()
            let calendar = Calendar.current
            _ = calendar.component(.hour, from: date)
            _ = calendar.component(.minute, from: date)
            let deathDate = calendar.date(byAdding: .minute, value: 6, to: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy-HH-mm"
            deathDateLabel.text = dateFormatter.string(from: deathDate!)
        }
        if (reasonLabel.text == "") {
            reasonLabel.text = "Hearth Attack"
        }
        let death = DeathDto(id: id, firstName: firstNameLabel.text!, lastName: lastNameLabel.text!, date: deathDateLabel.text!, reasonOfDeath: reasonLabel.text!, picture: profilePicture.image!)
        viewModel.confirmKill(death: death)
    }

    func errorAlert(errorMessage: String){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.show(self, sender: Any?.self)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


    @IBAction func killAction(_ sender: Any) {
        confrirmKill()
        self.performSegue(withIdentifier: "toHome", sender: nil)
    }

    @IBAction func dateAction(_ sender: Any) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.doneDatePickerPressed))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        deathDateLabel.inputView = datePickerView
        deathDateLabel.inputAccessoryView = toolBar
        datePickerView.addTarget(self, action: #selector(self.datePickerFromValueChanged), for: UIControlEvents.valueChanged)
    }

    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy-HH-mm"
        deathDateLabel.text = dateFormatter.string(from: sender.date)
    }

    @objc func doneDatePickerPressed(){
        self.view.endEditing(true)
    }
}
