//
//  AccountViewController.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 13/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameLabel: PTLabel!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = UserDefaults.standard.value(forKey: "Username") as? String ?? "Petros Tepoyan"
        profileImage.image = UIImage(named: "ProfileIcon")
        let image = loadImageFromDiskWith(fileName: "ProfilePicture")
        if image == nil {
            // handle nil
        } else {
            let image = loadImageFromDiskWith(fileName: "ProfilePicture")
            profileImage.image = image
        }
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.isUserInteractionEnabled = true
        
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped)))
    }
        
    @objc func profileImageTapped(sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not availible")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary

            self.present(imagePickerController, animated: true, completion: nil)

        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        saveImage(imageName: "ProfilePicture", image: image)
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension AccountViewController {

    func saveImage(imageName: String, image: UIImage) {


     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }

    }



    func loadImageFromDiskWith(fileName: String) -> UIImage? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image

        }

        return nil
    }
    
}
