//
//  ViewController.swift
//  Wasestagram
//
//  Created by 藤井陽介 on 2018/03/27.
//  Copyright © 2018 touyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView! {
        
        didSet {
            
            iconImageView.cornerRadius = iconImageView.bounds.width / 2
            iconImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var smallIconImageView: UIImageView! {
        
        didSet {
            
            smallIconImageView.cornerRadius = smallIconImageView.bounds.width / 2
            smallIconImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var likeTextField: UITextField! {
        didSet {
            likeTextField.delegate = self
        }
    }
    @IBOutlet weak var hashTextField: UITextField! {
        didSet {
            hashTextField.delegate = self
        }
    }
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    
    var isSelectIcon: Bool = true
    var text: String!
    var hashTag: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        
        let _ = UIAlertController(title: "保存", message: "保存しますか？", preferredStyle: .alert)
            .addAction(title: "OK", style: .default, handler: { _ in
                
                let image = self.getScreenShot()
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                let _ = UIAlertController(title: "保存しました", message: "画像が保存されました", preferredStyle: .alert)
                    .addAction(title: "OK")
                    .show()
            })
            .addAction(title: "Cancel", style: .cancel, handler: nil)
            .show()
    }
    
    @IBAction func changeIcon(_ sender: Any) {
        isSelectIcon = true
        showImageSelector()
    }
    
    @IBAction func changeImage(_ sender: Any) {
        isSelectIcon = false
        showImageSelector()
    }
    
    func showImageSelector() {
        let _ = UIAlertController(title: "写真を選択", message: "写真を選ぶ方法を選択してください。", preferredStyle: .actionSheet)
            .addAction(title: "アルバム", style: .default, handler: { _ in
                self.presentPickerController(sourceType: .photoLibrary)
            })
            .addAction(title: "カメラ", style: .default, handler: { _ in
                self.presentPickerController(sourceType: .camera)
            })
            .addAction(title: "キャンセル", style: .cancel, handler: nil)
            .show()
    }
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
    
    func getScreenShot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext() as! UIImage
        UIGraphicsEndImageContext()
        return image
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if isSelectIcon {
            iconImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            smallIconImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        } else {
            mainImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            label.isHidden = true
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

