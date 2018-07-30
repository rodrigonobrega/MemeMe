//
//  ViewController.swift
//  MemeMe
//
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    var memedImage:UIImage?
    
    // MARK: Struct Meme used to save
    struct Meme {
        var originalImage: UIImage
        var memedImage: UIImage
        
        
    }
    
    // MARK: Override UIViewController methods
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutDefault()
        save()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    func setupLayoutDefault() {
        self.topToolBar.isHidden = false
        self.bottomToolBar.isHidden = false
        let defaultTextAttributes:[NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40),
            NSAttributedStringKey.strokeWidth : -3.0
        ]
        self.topTextField.attributedText = NSAttributedString(string: "TOP", attributes: defaultTextAttributes)
        self.bottomTextField.attributedText = NSAttributedString(string: "BOTTOM", attributes: defaultTextAttributes)
    }
    
    func setupLayoutToSave() {
        self.topToolBar.isHidden = true
    }
    
    
    func generateMemedImage() -> UIImage {
        
        setupLayoutToSave()
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        setupLayoutDefault()
        
        return memedImage
    }
    
//    func prepareDisplayToShare(_ hidden: Bool) {
//        UIApplication.shared.isStatusBarHidden = hidden
//        self.topToolBar.isHidden = hidden
//        self.bottomToolBar.isHidden = hidden
//    }
    
    @IBAction func share(_ sender: Any) {
        
        memedImage = generateMemedImage()
        self.present(self.showActivityController(), animated: true, completion: nil)
    }
    
    func showActivityController()  -> UIActivityViewController {
        let message = "Sharing MemeMe"
        
        let objects:[AnyObject] = [message as AnyObject, memedImage!]
        
        let activityController = UIActivityViewController(activityItems: objects , applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            activity, success, items, error in
            
            let alertController = UIAlertController(title: "Save", message: "Do you like to save ?", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { (action:UIAlertAction) in
                if success {
                    self.save()
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        return activityController
    }
    
    func save() {
        if let selectedImage = imagePickerView.image {
            let memeObject = Meme(originalImage: selectedImage, memedImage: memedImage!)
            saveMemeImage(selectedImage)
            //saveIm(selectedImage)
        }
        
    }
    
    
    func saveMemeImage(_ memeToSave:UIImage) {
        
        setupLayoutToSave()
        
        let imageData = UIImagePNGRepresentation(memeToSave)
        let compressedImag = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImag!, nil, nil, nil)
//        if let constraintTopToolBarHeihtDefaultValue = constraintTopToolBarHeihtDefaultValue {
//            self.constraintBarHeight.constant  = constraintTopToolBarHeihtDefaultValue.constant;
//        }

        
    }
   
    
    
    
    
    
    

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

}

extension ViewController {
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image;
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    
    // MARK: UITextFieldDelegate, NotificationCenter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // MARK: NotificationCenter
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
