//
//  ViewController.swift
//  MemeMe
//
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    // MARK: @IBOutlet and variables
    @IBOutlet weak var scrollImageView: UIScrollView!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    var memedImage:UIImage?
    
    let defaultTextAttributes:[NSAttributedStringKey : Any] = [
        NSAttributedStringKey.strokeColor : UIColor.black,
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.font: UIFont(name: MememeConstants.textFont, size: MememeConstants.fontSize)!,
        NSAttributedStringKey.strokeWidth : MememeConstants.stroke
    ]

    let typingTextAttributes:[String : Any] = [
        NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
        NSAttributedStringKey.font.rawValue : UIFont(name: MememeConstants.textFont, size: MememeConstants.fontSize)!,
        NSAttributedStringKey.strokeWidth.rawValue : MememeConstants.stroke
    ]
    
    // MARK: Struct Meme used to save and Struct constants values
    struct Meme {
        var topTexFieldText:String!
        var bottomTextFieldText:String!
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    struct MememeConstants{
        static let textFont = "HelveticaNeue-CondensedBlack"
        static let messageActivityShare = "\nSharing my MemeMe"
        static let fontSize:CGFloat = 54.0
        static let stroke = -8.0
        static let minimumZoomScale:CGFloat = 1.0
        static let maximumZoomScale:CGFloat = 5.0
    }
    
    // MARK: Override UIViewController methods
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shareButton.isEnabled = false
        setupLayoutDefault()
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
    
    //MARK: @IBAction methods
    @IBAction func cancelSaveImage(_ sender: Any) {
        self.setupLayoutDefault()
        self.imagePickerView.image  = UIImage()
        self.topTextField.text = String()
        self.bottomTextField.text = String()
    }
    
    @IBAction func share(_ sender: Any) {
        memedImage = generateMemedImage()
        self.present(self.showActivityController(), animated: true, completion: nil)
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
    
    // MARK: Configure Layout methods
    func setupLayoutDefault() {
        
        self.scrollImageView.delegate = self
        self.scrollImageView.minimumZoomScale = MememeConstants.minimumZoomScale
        self.scrollImageView.maximumZoomScale = MememeConstants.maximumZoomScale
        self.shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.topToolBar.isHidden = false
        self.bottomToolBar.isHidden = false
        
        self.topTextField.attributedText = NSAttributedString(string: self.topTextField.text!, attributes: defaultTextAttributes)
        self.bottomTextField.attributedText = NSAttributedString(string: self.bottomTextField.text!, attributes: defaultTextAttributes)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imagePickerView
    }
    
    func setupLayoutToSave() {
        self.topToolBar.isHidden = true
        self.bottomToolBar.isHidden = true
    }
   
}

extension ViewController {
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image;
            self.shareButton.isEnabled = true
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.typingAttributes = typingTextAttributes
        return true
    }
    
}

extension ViewController {
    
    // MARK: NotificationCenter and keyboard methods
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder  {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // create a image to save
    func generateMemedImage() -> UIImage {
        
        setupLayoutToSave()
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        setupLayoutDefault()
        
        return memedImage
    }
    
    // show a Activity View Controller to share image
    func showActivityController()  -> UIActivityViewController {
        let objects:[AnyObject] = [MememeConstants.messageActivityShare as AnyObject, memedImage!]
        let activityController = UIActivityViewController(activityItems: objects , applicationActivities: nil)
        self.setupLayoutToSave()
        activityController.completionWithItemsHandler = {
            activity, success, items, error in
            self.setupLayoutDefault()
        }
        return activityController
    }
}
